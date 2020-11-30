# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

module MurmurRPC
  module Lifted
    # User GRPC endpoint/wrapper
    class User < RemoteObject
      # Initialize a new wrapper
      #
      # @param [Client] client Client
      # @param [Server] server Server
      # @param [Integer|MurmurRPC::User] user User identity
      def initialize(client, server, user)
        @msg_params = case user
                      when Integer
                        { server: server.identity, id: user }
                      when MurmurRPC::User
                        { server: server.identity, id: user.id }
                      else
                        raise 'Parameter user must be an integer or user message'
                      end

        super(client, MurmurRPC::User.new(@msg_params))
        @server = server
      end

      # Get user details
      #
      # @return [MurmurRPC::User] User message with details
      def details
        stub.user_get(identity)
      end

      # Update the user
      #
      # @see V1::Stub#user_update
      # @param [Hash] fields Fields to update
      # @option fields [String] :name User name
      # @option fields [Boolean] :mute User mute status
      # @option fields [Boolean] :deaf User deaf status
      # @option fields [Boolean] :suppress User suppress status
      # @option fields [Boolean] :priority_speaker User priority speaker status
      # @option fields [Channel|MurmurRPC::Channel] :channel User channel
      # @option fields [String] :comment User comment
      def update(fields = {})
        fields[:channel] = fields[:channel].identity if fields[:channel].is_a? Lifted::Channel

        stub.user_update(MurmurRPC::User.new(fields.merge(@msg_params)))
      end

      # Kick the user
      #
      # @see V1::Stub#user_kick
      # @param [Hash] fields Kick parameters
      # @option fields [User|MurmurRPC::User] :actor User responsible for the kick
      # @option fields [String] :reason Kick reason
      def kick!(fields = {})
        fields[:actor] = fields[:actor].identity if fields[:actor].is_a? Lifted::User

        stub.user_kick(MurmurRPC::User::Kick.new(fields.merge(server: server.identity, user: identity)))
      end

      # Send a message to this user
      #
      # @see Server#send_message
      # @param [String] body Message body
      def send_message(body)
        @server.send_message(body, users: [identity])
      end

      # Send a message as this user
      #
      # @see Server#send_message
      def send_message_as(body, params = {})
        @server.send_message(body, params.merge(actor: identity))
      end
    end
  end
end
