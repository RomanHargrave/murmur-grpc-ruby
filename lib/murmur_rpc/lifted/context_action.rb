# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

module MurmurRPC
  module Lifted
    # ContextAction wrapper
    class ContextAction < RemoteObject
      # rubocop:disable Metrics/MethodLength

      # Initialize a ContextAction
      #
      # @param [Client] client Client
      # @param [Server] server Server
      # @param [Symbol] context
      #  Target context. `:server` will place the action in the
      #  server context menu, `:channel` in the channel context
      #  menu, and `:user` in the user context menu.
      # @param [String] name Action name
      # @param [String] text Action text
      def initialize(client, server, context, name, text)
        context_enum = case context
                       when :server
                         MurmurRPC::ContextAction::Context::Server
                       when :channel
                         MurmurRPC::ContextAction::Context::Channel
                       when :user
                         MurmurRPC::ContextAction::Context::User
                       else
                         raise "Unknown ContextAction Context '#{context}'"
                       end

        params = {
          server: server.identity,
          context: context_enum,
          action: name,
          text: text
        }

        super(client, MurmurRPC::ContextAction.new(params))
      end
      # rubocop:enable Metrics/MethodLength

      # Add this ContextAction to a user
      #
      # @see V1::Stub#context_action_add
      # @param [User|MurmurRPC::User] user User being granted the ContextAction
      def add_to(user)
        stub.context_action_add(for_user(user))
      end

      # Remove this ContextAction from a user
      #
      # @see V1::Stub#context_action_remove
      # @param [User|MurmurRPC::User] user User to remove the context action from
      def remove_from(user)
        stub.context_action_remove(for_user(user))
      end

      # Remove this ContextAction from all users
      #
      # @see V1::Stub#context_action_remove
      def remove_from_all!
        stub.context_action_remove(identity)
      end

      # Receive a stream of events for this action.
      # The event stream will contain ContextAction messages
      # matching the `server` and `name` (action) parameters
      # of this ContextAction. They are not specific to a user.
      #
      # @see V1::Sub#context_action_events
      # @return [Enumerable<MurmurRPC::ContextAction>]
      #  An enumerable of ContextAction events. It should be
      #  noted that this enumerable will never "run out" of
      #  elements, instead it will block until a new element
      #  is available. For this reason, you will need to handle
      #  it in a separate thread.
      def events
        stub.context_action_events(identity)
      end

      private

      def for_user(user)
        ca_message = identity.clone

        ca_message.user = case user
                          when MurmurRPC::User
                            user
                          when User
                            user.identity
                          end

        ca_message
      end
    end
  end
end
