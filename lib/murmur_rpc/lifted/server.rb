# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

module MurmurRPC
  module Lifted
    # Server gRPC endpoint wrapper
    class Server < RemoteObject
      # Create a new Server wrapper
      #
      # @param [Client] client Client
      # @param [Integer|MurmurRPC::Server] server Server ID or message
      def initialize(client, server)
        super(client, case server
                      when Integer
                        MurmurRPC::Server.new(id: server)
                      when MurmurRPC::Server
                        MurmurRPC::Server.new(id: server.id)
                      else
                        raise 'Parameter server must be an integer or server message'
                      end)
      end

      # Start the virtual server
      #
      # @see V1::Stub#server_start
      def start!
        stub.server_start(identity)
      end

      # Stop the virtual server
      #
      # @see V1::Stub#server_stop
      def stop!
        stub.server_stop(identity)
      end

      # Remove the virtual server
      #
      # @see V1::Stub#server_remove
      def remove!
        stub.server_remove(identity)
      end

      # Receive a stream of the virtual server's events
      #
      # @see V1::Stub#server_events
      # @return [Enumerable<MurmurRPC::Server::Event>]
      #  An enumerable of server events. It should be noted that
      #  this enumerable will never "run out" of elements, instead
      #  it will block until a new element is available.
      #  For this reason, you will need to handle it in a
      #  separate thread.
      def events
        stub.server_events(identity)
      end

      # Send a text message
      #
      # @param [String] body Message body
      # @param [Hash] params Message parameters
      # @option params [User|MurmurRPC::User] :actor
      #  User who sent the message
      # @option params [Enumerable<User|MurmurRPC::User>] :users
      #  Users to whom the message is sent
      # @option params [Enumerable<Channel|MurmurRPC::Channel>] :channels
      #  Channels to which the message will be sent
      # @option params [Enumerable<Channel|MurmurRPC::Channel>] :trees
      #  Channels to which the message will be sent
      def send_message(body, params = {})
        fields = extract_identities(params).merge(
          server: identity,
          text: body
        )

        stub.text_message_send(MurmurRPC::TextMessage.new(fields))
      end

      # rubocop:disable Metrics/MethodLength

      # Attach a filter to the server's text message stream.
      # The filter should be given as a block or proc that
      # accepts a {MurmurRPC::TextMessage::Filter} and returns
      # the same {MurmurRPC::TextMessage::Filter} modified as
      # desired.
      #
      # This method does not return, and should be called in a
      # dedicated thread.
      def filter_messages
        responses = BlockingBuffer.new
        responses << MurmurRPC::TextMessage::Filter.new(server: identity)
        requests = stub.text_message_filter(responses)
        requests.each do |request|
          response = yield(request)

          if response.is_a? Symbol
            request.action = case response
                             when :accept
                               MurmurRPC::TextMessage::Filter::Action::Accept
                             when :reject
                               MurmurRPC::TextMessage::Filter::Action::Reject
                             when :drop
                               MurmurRPC::TextMessage::Filter::Action::Drop
                             end
            response = request
          else
            response.action = MurmurRPC::TextMessage::Filter::Action::Drop unless response.has_action?
          end

          responses << response
        end
      end
      # rubocop:enable Metrics/MethodLength

      # Retrieve log messages
      #
      # @param [Hash] params Query parameters
      # @option params [Integer] :min Minimum log message index
      # @option params [Integer] :max Maximum log message index
      # @return [MurmurRPC::Log::List] Log messages
      def query_log(params = {})
        stub.log_query(MurmurRPC::Log::Query.new(params.merge(server: identity)))
      end

      # Retrieve the server configuration. The configuration contains
      # any fields explicitly set for this server.
      #
      # @return [Config] Configuration wrapper
      def config
        Config.new(self)
      end

      # Retrieve the default configuration
      #
      # @return [MurmurRPC::Config] Configuration message with default keys/values
      def default_config
        # https://github.com/protocolbuffers/protobuf/issues/8097
        raise 'The configuration message is presently not supported due to an issue with protobuf'
      end

      # Wrapper for server-level configuration
      class Config
        extend Enumerable

        delegate :stub, to: @server

        # Create a new configuration wrapper
        def initialize(server)
          @server = server
        end

        # Get a configuration field
        #
        # @param [String] key Configuration field name
        def [](key)
          @server.stub.config_get_field(MurmurRPC::Config::Field.new(server: @server, key: key)).value
        end

        # Set a configuration field
        #
        # @param [String] key Configuration field name
        # @param [String] value Configuration field value
        def []=(key, value)
          @server.stub.config_set_field(MurmurRPC::Config::Field.new(server: @server, key: key, value: value.to_s))
        end

        # Iterate through fields and their values in the configuration
        def each
          # https://github.com/protocolbuffers/protobuf/issues/8097
          raise 'The configuration message is presently not supported due to an issue with protobuf'
        end
      end # class Config
    end # class Server
  end
end
