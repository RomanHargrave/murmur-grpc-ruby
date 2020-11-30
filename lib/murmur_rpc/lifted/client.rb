# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

require_relative 'lifted'

module MurmurRPC
  module Lifted
    # High-level Murmur gRPC client
    class Client
      # Constant {MurmurRPC::Void} message
      Void = MurmurRPC::Void.new

      # GRPC Stub
      attr_reader :stub

      # Create a new client
      #
      # @param [String] host The host that the client will connect to, including port
      # @param [Hash] params Additional parameters
      # @option params [GRPC::Core::ChannelCredentials|Symbol] :credentials (:this_channel_is_insecure)
      #  Channel credentials
      # @option params [Enumerable<GRPC::KeywordArgs>] :keywords ([]) Channel arguments, plus any option args for
      #  configuring the client's channel
      def initialize(host, params = {})
        @host = host
        @creds = params.fetch(:credentials, :this_channel_is_insecure)
        @channel_keywords = params.fetch(:keywords, [])
        @stub = V1::Stub.new(@host, @creds, *@channel_keywords)
      end

      # Request the murmur server version
      #
      # @return [Version] Server version information
      def version
        stub.get_version(Void)
      end

      # Request the server uptime
      #
      # @return [Integer] Server uptime in seconds
      def uptime
        stub.get_uptime(Void).secs
      end

      # Receive a stream of murmur's events
      #
      # @return [Enumerable<Event>]
      #  An enumerable of events. It should be noted that this
      #  enumerable will never "run out" of elements, instead
      #  it will block until a new element is available.
      #  For this reason, you will need to handle it in a
      #  separate thread.
      def events
        stub.events(Void)
      end

      # Retrieve a virtual server interface for the given server ID
      #
      # @param [Integer] id Server ID
      # @return [Lifted::Server] Server
      def server(id)
        Lifted::Server.new(id)
      end
    end

    # @private
    # Base class for wrappers that accept a {Client}
    class RemoteObject
      # @!attribute [r] stub
      #  @return [V1::Stub] Connection stub
      delegate :stub, to: @client

      # Identity message
      attr_reader :identity

      # Endpoint group constructor.
      #
      # @param [Client] client Client
      # @param identity Object identity message
      def initialize(client, identity)
        @client = client
        @identity = identity
      end
    end

    # @private
    # Object that has an RPC message associated with it
    module WithIdentityMessage
      # Identity message associated with this object
      attr_reader :identity
    end
  end
end
