# frozen_string_literal: true

# Murmur RPC client for Ruby
# This file contains stubs and YARD hacks necessary to document generated PB code
# Don't require this file
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

raise 'This file should not be required'

# rubocop:disable Naming/ConstantName, Lint/UnreachableCode

module MurmurRPC
  # gRPC Message `MurmurRPC.Void`
  #
  # Empty message
  class Void; end

  # gRPC Message `MurmurRPC.Version`
  #
  # This message is used both for server version information as well as client version information
  #
  # @!attribute [rw] version
  #   @return [Integer] 2-byte Major, 1-byte Minor and 1-byte Patch version number
  # @!attribute [rw] name
  #   @return [String] Client release name
  # @!attribute [rw] os
  #   @return [String] Client operating system name
  # @!attribute [rw] os_version
  #   @return [String] Client operating system version
  class Version; end

  # gRPC Message `MurmurRPC.Uptime`
  #
  # This message is used to communicate the uptime, in seconds, of a real or virtual server.
  #
  # @!attribute [rw] secs
  #   @return [Integer] Uptime in seconds
  class Uptime; end

  # gRPC Message `MurmurRPC.Server`
  #
  # This message contains information about a virtual server.
  #
  # @!attribute [rw] id
  #   @return [Integer] Server ID
  # @!attribute [rw] running
  #   @return [Boolean] Is the server currently running?
  # @!attribute [rw] uptime
  #   @return [Uptime] Server uptime
  class Server
    # gRPC Message `MurmurRPC.Server.Event`
    #
    # This message contains information about a server event.
    #
    # @!attribute [rw] server
    #   @return [Server] Server on which the event happened
    # @!attribute [rw] type
    #   @return [Event::Type] Type of event that happened
    # @!attribute [rw] user
    #   @return [User] User associated with event, if applicable
    # @!attribute [rw] message
    #   @return [TextMessage] Message associated with event, if applicable
    # @!attribute [rw] channel
    #   @return [Channel] Channel associated with event, if applicable
    class Event
      # gRPC Enumeration `MurmurRPC.Server.Event.Type`
      #
      # Event type enumuration
      class Type
        # A user connected (0)
        UserConnected = new

        # A user disconnected (1)
        UserDisconnected = new

        # User state changed (2)
        UserStateChanged = new

        # User sent a text message (3)
        UserTextMessage = new

        # A channel was created (4)
        ChannelCreated = new

        # A channel was removed (5)
        ChannelRemoved = new

        # Chanel modified (6)
        ChannelStateChanged = new
      end # module Type
    end # class Event

    # gRPC Message `MurmurRPC.Server.Query`
    #
    # Server query message. Empty.
    class Query; end

    # gRPC Message `MurmurRPC.Server.List`
    #
    # Server listing.
    #
    # @!attribute [rw] servers
    #   @return [Enumerable<Server>] Servers
    class List; end
  end # class Server

  # gRPC Message `MurmurRPC.Event`
  #
  # System event that is presently only emitted for virtual server lifecycle events
  #
  # @!attribute [rw] server
  #   @return [Server] Server for which the event happened
  # @!attribute [rw] type
  #   @return [Event::Type] Event type
  class Event
    # gRPC Enumeration `MurmurRPC.Event.Type`
    #
    # Describes event type
    class Type
      # A virtual server was stopped (0)
      ServerStopped = new

      # A server was started (1)
      ServerStarted = new
    end # module Type
  end # class Event

  # gRPC Message `MurmurRPC.ContextAction`
  #
  # Describes an entry in a user's client's context menu
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] context
  #   @return [Integer] Context (see {ContextAction::Context})
  class ContextAction
    # gRPC Enumeration `MurmurRPC.ContextAction.Context`
    #
    # Dictates which context menu the action will be added to
    module Context
      # The server context menu
      Server = 1

      # The channel context menu
      Channel = 2

      # The user context menu
      User = 3
    end # class Context
  end # class ContextAction

  # gRPC Message `MurmurRPC.TextMessage`
  #
  # A chat message
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] actor
  #   @return [User] User who sent the message
  # @!attribute [rw] users
  #   @return [Enumerable<User>] User(s) to whom the message was sent
  # @!attribute [rw] channels
  #   @return [Enumerable<Channel>] Channel(s) to which the message was sent
  # @!attribute [rw] trees
  #   @return [Enumerable<Channel>] Channel(s) to which the message was sent, including their ancestors
  # @!attribute [rw] text
  #   @return [String] Message body
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [User] :actor User to which the message is attributed
  #   @option params [Enumerable<User>] :users Users to whom the message will be sent
  #   @option params [Enumerable<Channel>] :channels Channels to which the message will be sent
  #   @option params [Enumerable<Channel>] :trees Channels to which the message will be sent, incl. ancestors
  #   @option params [String] :text Message body
  #   @return [TextMessage]
  class TextMessage
    # gRPC Message `MurmurRPC.TextMessage.Filter`
    #
    # Represents a message filter request and/or decision.
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] action
    #   @return [Filter::Action] Decision
    # @!attribute [rw] message
    #   @return [TextMessage] Message
    class Filter
      # gRPC Enumeration `MurmurRPC.TextMessage.Filter.Action`
      #
      # Describes a filter decision
      class Action
        # Accept the message
        Accept = new

        # Reject the message
        Reject = new

        # Silently drop the message
        Drop = new
      end # class Action
    end # class Filter
  end # class TextMessage

  # gRPC Message `MurmurRPC.Log`
  #
  # A log entry.
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] timestamp
  #   @return [Integer] Time (unix) that the message was generated
  # @!attribute [rw] message
  #   @return [String] Log message
  class Log
    # gRPC Message `MurmurRPC.Log.Query`
    #
    # Represents a request for log entries.
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] min
    #   @return [Integer] The minimum log index to receive
    # @!attribute [rw] max
    #   @return [Integer] The maximum log index to receive
    # @!method initialize(params = {})
    #   @param [Hash] params Parmeters
    #   @option params [Server] :server Server
    #   @option params [Integer] :min The minimum log index to receive
    #   @option params [Integer] :max The maximum log index to receive
    class Query; end

    # gRPC Message `MurmurRPC.Log.List`
    #
    # Represents a query response containing log entries
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] total
    #   @return [Integer] Number of results
    # @!attribute [rw] min
    #   @return [Integer] Minimum log entry index
    # @!attribute [rw] max
    #   @return [Integer] Maximum log entry index
    # @!attribute [rw] entries
    #   @return [Enumerable<Log>] Entries
    class List; end
  end # class Log

  # gRPC Message `MurmurRPC.Config`
  #
  # Describes server configuration
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] fields
  #   @return [Hash<String, String>] Filed names/values
  class Config
    # gRPC Message `MurmurRPC.Config.Field`
    #
    # A configuration entry
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] key
    #   @return [String] Field name
    # @!attribute [rw] value
    #   @return [String] Field value
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @option params [String] :key Field name
    #   @option params [String] :value Field value
    class Field; end
  end # class Config

  # gRPC Message `MurmurRPC.Channel`
  #
  # Contains information about a channel
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] id
  #   @return [Integer] Channel ID
  # @!attribute [rw] name
  #   @return [String] Name
  # @!attribute [rw] parent
  #   @return [Channel] Parent channel
  # @!attribute [rw] links
  #   @return [Enumerable<Channel>] Linked channels
  # @!attribute [rw] description
  #   @return [String] Channel comment/description
  # @!attribute [rw] temporary
  #   @return [Boolean] Is the channel temporary?
  # @!attribute [rw] position
  #   @return [Integer] Channel position in parent
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [Integer] :id Channel ID
  #   @option params [String] :name Channel name
  #   @option params [Channel] :parent Channel parent
  #   @option params [Enumerable<Channel>] :links Linked channels
  #   @option params [String] :description Channel comment/description
  #   @option params [Boolean] :temporary Is the channel temporary?
  #   @option params [Integer] :position Channel position in parent
  #   @return [Channel]
  class Channel
    # gRPC Message `MurmurRPC.Channel.Query`
    #
    # Contains information about a channel listing request
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @return [Query]
    class Query; end

    # gRPC Message `MurmurRPC.Channel.List`
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] channels
    #   @return [Enumerable<Channel>] Channels
    class List; end
  end # class Channel

  # gRPC Message `MurmurRPC.User`
  #
  # Contains information about a connected user
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] session
  #   @return [Integer] The user's session ID
  # @!attribute [rw] id
  #   @return [Integer] The user's registered (database) ID
  # @!attribute [rw] name
  #   @return [String] The user's name
  # @!attribute [rw] muted
  #   @return [Boolean] Whether the user is muted
  # @!attribute [rw] deaf
  #   @return [Boolean] Whether the user is deafened
  # @!attribute [rw] suppress
  #   @return [Boolean] Whether the user is suppressed
  # @!attribute [rw] priority_speaker
  #   @return [Boolean] Whether the user is a priority speaker
  # @!attribute [rw] self_mute
  #   @return [Boolean] Whether the user is self-muted
  # @!attribute [rw] self_deaf
  #   @return [Boolean] Whether the user is self-deafened
  # @!attribute [rw] recording
  #   @return [Boolean] Whether the user is recording
  # @!attribute [rw] channel
  #   @return [Channel] The channel that the user is in
  # @!attribute [rw] online_secs
  #   @return [Integer] How long the user has been connected to the server
  # @!attribute [rw] idle_secs
  #   @return [Integer] Number of seconds since last activity
  # @!attribute [rw] bytes_per_sec
  #   @return [Integer] How many BPS is the user transmitting to the server?
  # @!attribute [rw] version
  #   @return [Version] User version information
  # @!attribute [rw] plugin_context
  #   @return [String] Plugin context (bytes)
  # @!attribute [rw] plugin_identity
  #   @return [String] The user's plugin identity
  # @!attribute [rw] comment
  #   @return [String] The user's comment
  # @!attribute [rw] texture
  #   @return [String] The user's texture (bytes)
  # @!attribute [rw] address
  #   @return [String] The user's IP address (bytes)
  # @!attribute [rw] tcp_only
  #   @return [Boolean] Is the user in TCP-only mode?
  # @!attribute [rw] udp_ping_msecs
  #   @return [Float] The user's UDP ping in milliseconds
  # @!attribute [rw] tcp_ping_msecs
  #   @return [Float] The user's TCP ping in milliseconds
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [Integer] :id User ID
  #   @option params [String] :name User name
  #   @option params [Boolean] :muted Muted?
  #   @option params [Boolean] :deafened Deaf?
  #   @option params [Boolean] :suppress Suppressed?
  #   @option params [Boolean] :priority_speaker Has priority speaker?
  #   @option params [Channel] :channel Channel that the user is in
  #   @option params [String] :comment User comment
  #   @return [User]
  class User
    # gRPC Message `MurmurRPC.User.Query`
    #
    # Represents a query for users
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @return [Query]
    class Query; end

    # gRPC Message `MurmurRPC.User.List`
    #
    # A listing of users
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] users
    #   @return [Enumerable<User>] Users
    class List; end

    # gRPC Message `MurmurRPC.User.Kick`
    #
    # User kick reason
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] user
    #   @return [User] User being kicked
    # @!attribute [rw] actor
    #   @return [User] User responsible for the kick
    # @!attribute [rw] reason
    #   @return [String] Kick reason
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @option params [User] :user User being kicked
    #   @option params [User] :actor User responsible for the kick
    #   @option params [String] :reason Kick reason
    #   @return [Kick]
    class Kick; end
  end # class User

  # gRPC Message `MurmurRPC.Tree`
  #
  # Channel tree
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] channel
  #   @return [Channel] Current channel
  # @!attribute [rw] children
  #   @return [Enumerable<Tree>] Channels below this channel
  # @!attribute [rw] users
  #   @return [Enumerable<User>] Users in this channel
  class Tree
    # gRPC Message `MurmurRPC.Tree.Query`
    #
    # Tree query
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    class Query; end
  end # class Tree

  # gRPC Message `MurmurRPC.Ban`
  #
  # Represents a user, certificate, or IP address ban
  #
  # @!attribute [rw] server
  #   @return [Server] Server
  # @!attribute [rw] address
  #   @return [String] Banned IP address (bytes)
  # @!attribute [rw] bits
  #   @return [Integer] IP address mask length in bits
  # @!attribute [rw] name
  #   @return [String] Banned user
  # @!attribute [rw] hash
  #   @return [String] Banned certificate hash
  # @!attribute [rw] reason
  #   @return [String] Ban reason
  # @!attribute [rw] start
  #   @return [Integer] Ban start time (unix)
  # @!attribute [rw] duration_secs
  #   @return [Integer] Ban duration in seconds
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [String] :address Banned address
  #   @option params [Integer] :bits Banned address mask length
  #   @option params [String] :name Banned user name
  #   @option params [String] :hash Banned cert hash
  #   @option params [String] :reason Ban reason
  #   @option params [Integer] :start Ban start date/time (unix)
  #   @option params [Integer] :duration_secs Ban duration in seconds
  #   @return [Ban]
  class Ban
    # gRPC Message `MurmurRPC.Ban.Query`
    #
    # Ban query
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @return [Query]
    class Query; end

    # gRPC Message `MurmurRPC.Ban.List`
    #
    # Ban list
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] bans
    #   @return [Enumerable<Ban>] Bans
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @option params [Enumerable<Ban>] :bans Bans
    #   @return [List]
    class List; end
  end # class Ban

  # gRPC Message `MurmurRPC.ACL`
  #
  # Access control list
  #
  # @!attribute [rw] apply_here
  #   @return [Boolean] Applies to current channel?
  # @!attribute [rw] apply_subs
  #   @return [Boolean] Applies to sub-channels?
  # @!attribute [rw] inherited
  #   @return [Boolean] Was this ACL inherited?
  # @!attribute [rw] user
  #   @return [DatabaseUser] User to whom the ACL applies
  # @!attribute [rw] group
  #   @return [ACL::Group] Group to whom the ACL applies
  # @!attribute [rw] allow
  #   @return [Integer] Bitmask of permissions granted by this ACL (see {ACL::Permission})
  # @!attribute [rw] deny
  #   @return [Integer] Bitmask of permissions denied by this ACL (see {ACL::Permission})
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Boolean] :apply_here Applies in current channel?
  #   @option params [Boolean] :apply_subs Applies in sub-channels?
  #   @option params [DatabaseUser] :user User to whom the ACL applies
  #   @option params [ACL::Group] :group Group to whom the ACL applies
  #   @option params [Integer] :allow Allowed permissions bitmask
  #   @option params [Integer] :deny Denied permissions bitmask
  #   @return [ACL]
  class ACL
    # gRPC Enumeration `MurmurRPC.ACL.Permission`
    #
    # Permission bits
    # Actual type not used. Only values are.
    module Permission
      # Empty
      None = 0x00
      
      # Can edit ACL?
      Write = 0x01
      
      # Can move
      Traverse = 0x02
      
      # Can enter
      Enter = 0x04

      # Can speak
      Speak = 0x08

      # Can whisper
      Whisper = 0x100

      # Can mute/deafen other users
      MuteDeafen = 0x10

      # Can move channels/users
      Move = 0x20

      # Can make normal channels
      MakeChannel = 0x40

      # Can make temporary channels
      MakeTemporaryChannel = 0x400

      # Can Link channels
      Link = 0x80

      # Can send message
      TextMessage = 0x200

      # Can kick users
      Kick = 0x10000

      # Can ban users
      Ban = 0x20000

      # Can register other users
      Register = 0x40000

      # Can register self
      RegisterSelf = 0x80000
    end # module Permission

    # gRPC Message `MurmurRPC.ACL.Group`
    #
    # Group of users
    #
    # @!attribute [rw] name
    #   @return [String] Group name
    # @!attribute [rw] inherited
    #   @return [Boolean] Was this group inherited?
    # @!attribute [rw] inherit
    #   @return [Boolean] Does this group inherit members?
    # @!attribute [rw] inheritable
    #   @return [Boolean] Can this group be inherited?
    # @!attribute [rw] users_add
    #   @return [Enumerable<DatabaseUser>] Users added by this group
    # @!attribute [rw] users_remove
    #   @return [Enumerable<DatabaseUser>] Users removed by this group
    # @!attribute [rw] users
    #   @return [Enumerable<DatabaseUser>] Users who are part of this group
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [String] :name Group name
    #   @option params [Boolean] :inherit Does this group inherit members?
    #   @option params [Boolean] :inheritable Can this group be inherited?
    #   @option params [Enumerable<DatabaseUser>] :users_add Users added by this group
    #   @option params [Enumerable<DatabaseUser>] :users_remove Users removed by this group
    #   @option params [Enumerable<DatabaseUser>] :users Users who are part of this group
    #   @return [Group]
    class Group; end

    # gRPC Message `MurmurRPC.ACL.Query`
    #
    # ACL Query
    #
    # @!attribute [rw] server
    #   @return [Server] Server to search
    # @!attribute [rw] user
    #   @return [User] User to search
    # @!attribute [rw] channel
    #   @return [Channel] Channel to search
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server to search
    #   @option params [User] :user User to search
    #   @option params [Channel] :channel Channel to search
    #   @return [Query]
    class Query; end

    # gRPC Message `MurmurRPC.ACL.List`
    #
    # Relationship between ACLs and a channel
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] channel
    #   @return [Channel] Channel to which the list applies
    # @!attribute [rw] acls
    #   @return [Enumerable<ACL>] ACLs applicable to the channel
    # @!attribute [rw] groups
    #   @return [Group] ACL groups applicable to the channel
    # @!attribute [rw] inherit
    #   @return [Boolean] Inherit ACLs from the parent channel?
    # @method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @option params [Channel] :channel Channel to which ACLs apply
    #   @option params [Enumerable<ACL>] :acls ACLs applied to the channel
    #   @option params [Enumerable<Group>] :groups Applicable groups
    #   @option params [Boolean] :inherit Inherit ACLs from the parent channel?
    #   @return [List]
    class List; end
    
    # gRPC Message `MurmurRPC.ACL.TemporaryGroup`
    #
    # Temporary group
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] channel
    #   @return [Channel] Channel to which the temporary group is added
    # @!attribute [rw] user
    #   @return [User] User added to the temporary group
    # @!attribute [rw] name
    #   @return [String] Name of the temporary group
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option [Server] :server Server
    #   @option [Channel] :channel Channel to which the group will be added
    #   @option [User] :user User added to the group
    #   @option [String] :name Name of the group
    #   @return [TemporaryGroup]
    class TemporaryGroup; end
  end # class ACL

  # gRPC Message `MurmurRPC.Authenticator`
  class Authenticator
    # gRPC Message `MurmurRPC.Authenticator.Request`
    #
    # @!attribute [rw] authenticate
    #   @return [Authenticate] Authenticate message
    # @!attribute [rw] find
    #   @return [Find] Find criteria
    # @!attribute [rw] query
    #   @return [Query] User query
    # @!attribute [rw] register
    #   @return [DatabaseUser] User to register
    # @!attribute [rw] deregister
    #   @return [DatabaseUser] User to de-register
    # @!attribute [rw] update
    #   @return [DatabaseUser] User to update
    class Request
      # gRPC Message `MurmurRPC.Authenticator.Request.Authenticate`
      #
      # Authentication request for a connecting user
      #
      # @!attribute [rw] name
      #   @return [String] User name
      # @!attribute [rw] password
      #   @return [String] User password
      # @!attribute [rw] certificate
      #   @return [String] DER certificate chain for user (bytes)
      # @!attribute [rw] certificate_hash
      #   @return [String] User certificate hash
      # @!attribute [rw] strong_certificate
      #   @return [String] Is the user connecting with a strong certificate?
      class Authenticate; end

      # gRPC Message `MurmurRPC.Authenticator.Request.Find`
      #
      # Request for information about a user
      #
      # @!attribute [rw] id
      #   @return [Integer] User ID
      # @!attribute [rw] name
      #   @return [String] User name
      class Find; end

      # gRPC Message `MurmurRPC.Authenticator.Request.Query`
      #
      # Request to search users
      #
      # @!attribute [rw] filter
      #   @return [String] User name filter (`%` is a wildcard)
      class Query; end

      # gRPC Message `MurmurRPC.Authenticator.Request.Register`
      #
      # Request to register a user
      #
      # @!attribute [rw] user
      #   @return [DatabaseUser] User to register
      class Register; end

      # gRPC Message `MurmurRPC.Authenticator.Request.Deregister`
      #
      # Request to de-register a user
      #
      # @!attribute [rw] user
      #   @return [DatabaseUser] User to de-register
      class Deregister; end

      # gRPC Message `MurmurRPC.Authenticator.Request.Update`
      #
      # Request to update a user
      #
      # @!attribute [rw] user
      #   @return [DatabaseUser] User to update
      class Update; end
    end # class Request

    # gRPC Message `MurmurRPC.Authenticator.Response`
    #
    # Response to an authentication request
    #
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Response::Initialize] :initialize Init message
    #   @option params [Response::Authenticate] :authenticate Auth response
    #   @option params [Response::Find] :find Find response
    #   @option params [Response::Query] :query Query response
    #   @option params [Response::Register] :register Register response
    #   @option params [Response::Deregister] :deregister De-register response
    #   @option params [Response::Update] :update Update response
    #   @return [Response]
    class Response
      # gRPC Message `MurmurRPC.Authenticator.Response.Initialize`
      #
      # Tells the server that this RPC client will handle authentication going forward.
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Server] :server Server
      #   @return [Initialize]
      class Initialize; end

      # gRPC Enumeration `MurmurRPC.Authenticator.Response.Status`
      #
      # Action status
      class Status
        # The request should be handled by the server
        Fallthrough = new

        # The request was successful
        Success = new

        # The request failed
        Failure = new

        # There was a temporary failure
        TemporaryFailure = new
      end

      # gRPC Message `MurmurRPC.Authenticator.Response.Authenticate`
      #
      # Authentication response
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Status] :status Operation status
      #   @option params [Integer] :id The user's registered ID
      #   @option params [String] :name The user's name (as registered)
      #   @option params [Enumerable<ACL::Group>] :groups Groups that the user belongs to
      #   @return [Authenticate]
      class Authenticate; end

      # gRPC Message `MurmurRPC.Authenticator.Response.Find
      #
      # User lookup response
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [DatabaseUser] :user User, if found
      #   @return [Find]
      class Find; end

      # gRPC Message `MurmurRPC.Authenticator.Response.Query`
      #
      # User query results
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Enumerable<DatabaseUser>] :users Matched users
      #   @return [Query]
      class Query; end

      # gRPC Message `MurmurRPC.Authenticator.Response.Register`
      #
      # User registration response
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Status] :status Operation status
      #   @option params [DatabaseUser] :user The user as registered in the database
      #   @return [Register]
      class Register; end

      # gRPC Message `MurmurRPC.Authenticator.Response.Deregister`
      #
      # User de-registration response
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Status] :status Operation status
      #   @return [Deregister]
      class Deregister; end

      # gRPC Message `MurmurRPC.Authenticator.Response.Update`
      #
      # User update response
      #
      # @!method initialize(params = {})
      #   @param [Hash] params
      #   @option params [Status] :status Operation status
      #   @return [Update]
      class Update; end
    end # class Response
  end # class Authenticator

  # gRPC Message `MurmurRPC.DatabaseUser`
  #
  # Database entry for a registered user
  #
  # @!attribute [rw] server
  #   @return [Server] Server on which the user is registered
  # @!attribute [rw] id
  #   @return [Integer] User ID
  # @!attribute [rw] name
  #   @return [String] User name
  # @!attribute [rw] email
  #   @return [String] User email address
  # @!attribute [rw] comment
  #   @return [String] User comment
  # @!attribute [rw] hash
  #   @return [String] User certificate hash
  # @!attribute [rw] last_active
  #   @return [String] When the user was last seen (ISO-8601 Date/Time?)
  # @!attribute [rw] texture
  #   @return [String] User texture (bytes). Avatar?
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [Integer] :id User ID
  #   @option params [String] :name User name
  #   @option params [String] :email User email
  #   @option params [String] :comment User comment
  #   @option params [String] :hash User certificate hash
  #   @option params [String] :password User password
  #   @option params [String] :texture User texture
  #   @return [DatabaseUser]
  class DatabaseUser
    # gRPC Message `MurmurRPC.DatabaseUser.Query`
    #
    # Query {DatabaseUser}s
    #
    # @!attribute [rw] server
    #   @return [Server] Server
    # @!attribute [rw] filter
    #   @return [String] User filter string
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server
    #   @option params [String] :filter User filter
    #   @return [Query]
    class Query; end

    # gRPC Message `MurmurRPC.DatabaseUser.List`
    #
    # A list of {DatabaseUser}s
    #
    # @!attribute [rw] server
    #   @return [Server] Server on which the users are registered
    # @!attribute [rw] users
    #   @return [Enumerable<DatabaseUser>] Users
    class List; end

    # gRPC Message `MurmurRPC.DatabaseUser.Verify`
    #
    # Verify a user's password
    #
    # @!method initialize(params = {})
    #   @param [Hash] params
    #   @option params [Server] :server Server to verify with
    #   @option params [String] :name User name
    #   @option params [String] :password User password
    #   @return [Verify]
    class Verify; end
  end # class DatabaseUser

  # gRPC Message `MurmurRPC.RedirectWhisperGroup`
  #
  # Configure a whisper redirect
  #
  # @!method initialize(params = {})
  #   @param [Hash] params
  #   @option params [Server] :server Server
  #   @option params [User] :user User to whom the redirection will be applied
  #   @option params [ACL::Group] :group Source group
  #   @option params [ACL::Group] :target Target group
  #   @return [RedirectWhisperGroup]
  class RedirectWhisperGroup; end

  # Murmur gRPC V1 Service
  module V1
    # Internal gRPC service specification
    class Service; end

    # Murmur gRPC V1 Service Stub
    #
    # @!method get_uptime()
    #   Get the root server's uptime
    #
    #   @return [Uptime] Server uptime
    # @!method get_version()
    #   Get the root server's version information
    #
    #   @return [Version] Version information
    # @!method events()
    #   Get a stream of events
    #
    #   @return [Enumerable<Event>] Events
    #
    # @!method server_create()
    #   Create a virtual server
    #
    #   @return [Server] New virtual server
    # @!method server_query(query)
    #   Retrieve a list of virtual servers
    #
    #   @param [Server::Query] query Query
    #   @return [Server::List] Virtual server listing
    # @!method server_get(server)
    #   Get information about a given server
    #
    #   @param [Server] server Partial (or complete) server message
    #   @return [Server] Complete server message
    # @!method server_start(server)
    #   Start a virtual server
    #
    #   @param [Server] server Virtual server to start
    # @!method server_stop(server)
    #   Stop a virtual server
    #
    #   @param [Server] server Virtual server to stop
    # @!method server_remove(server)
    #   Remove a virtual server
    #
    #   @param [Server] server Virtual server to remove
    # @!method server_events(server)
    #   Get an event stream for a virtual server
    #
    #   @param [Server] server Virtual server to retrieve events for
    #   @return [Enumerable<Server::Event>] Server event stream
    #
    # @!method context_action_add(context_action)
    #   Add a context action
    #
    #   The following fields must be set:
    #
    #   * `context`
    #   * `action`
    #   * `text`
    #   * `user`
    #
    #   @param [ContextAction] context_action Context action to add
    # @!method context_action_remove(context_action)
    #   Remove a context action
    #
    #   The `action` field must be set.
    #
    #   @param [ContextAction] context_action Context action to remove
    # @!method context_action_events(context_action)
    #   Get context action events
    #
    #   The `action` field must be set.
    #   @param [ContextAction] context_action Context action to retrieve events
    #
    #   @return [Enumerable<ContextAction>] Stream of events
    #
    # @!method text_message_send(text_message)
    #   Send the given text message to the server.
    #
    #   If no users, channels, or trees are specified, the message will be broadcast
    #   to the entire server. Otherwise it will be targeted as specified.
    #
    #   @param [TextMessage] text_message Text message to send
    # @!method text_message_field(filter)
    #   Filter server text messages
    #
    #   When a filter stream is active, text messages sent from users to the server
    #   are sent over the stream. The RPC client then sends a message back on the same
    #   stream, containing an action: whether the message should be accepted, rejected, or dropped.
    #
    #   To activate the filter stream, an initialize {TextMessage::Filter} message must be sent
    #   that contains the {Server} on which the filter will be active.
    #
    #   @param [Enumerable<TextMessage::Filter>] filter Outgoing messages
    #   @return [Enumerable<TextMessage::Filter>] Incoming messages
    #
    # @!method log_query(query)
    #   Returns a list of log entries from the given server.
    #
    #   To get the total number of entries, omit min/max from the query.
    #
    #   @param [Log::Query] query Query
    #   @return [Log::List] Messages
    #
    # @!method config_get(server)
    #   Get explicitly set configuration parameters for the given server.
    #
    #   @param [Server] server Server
    #   @return [Config]
    # @!method config_get_field(field)
    #   Get a configuration value for the given key
    #
    #   @param [Config::Field] field Message containing key
    #   @return [Config::Field] Completed field message
    # @!method config_set_field(field)
    #   Set the configuration value for a given key
    #
    #   @param [Config::Field] field Message with key and desired value
    # @!method config_get_default()
    #   Get the default server configuration
    #
    #   @return [Config] Default configuration
    #
    # @!method channel_query(query)
    #   Retrieve a list of channels matching the given query
    #
    #   @param [Channel::Query] query Channel query
    #   @return [Channel::List] Matched channels
    # @!method channel_get(channel)
    #   Retrieve channel details for the given channel ID
    #
    #   @param [Channel] channel Channel message with ID
    #   @return [Channel] Completed channel message
    # @!method channel_add(channel)
    #   Add a channel. The `parent` and `name` fields must be set.
    #
    #   @param [Channel] channel Channel to add
    #   @return [Channel] Added channel
    # @!method channel_remove(channel)
    #   Remove the given channel.
    #
    #   @param [Channel] channel Channel to remove
    # @!method channel_update(channel)
    #   Update the given channel. Only fields that are present will be updated.
    #
    #   @param [Channel] channel Channel to update
    #   @return [Channel] Updated channel
    #
    # @!method user_query(query)
    #   Query connected users
    #
    #   @param [User::Query] query User query
    #   @return [User::List] Matched users
    # @!method user_get(user)
    #   Retrieve details about the given user, provided either
    #   a `session` or `name`.
    #
    #   @param [User] user User identifiers
    #   @return [User] Completed user details
    # @!method user_update(user)
    #   Update the given user.
    #
    #   The following fields may be changed:
    #
    #   * `name`
    #   * `mute`
    #   * `deaf`
    #   * `suppress`
    #   * `priority_speaker`
    #   * `channel`
    #   * `comment`
    #
    #   @param [User] user User to update
    #   @return [User] Updated user
    # @!method user_kick(kick)
    #   Kick a user
    #
    #   @param [User::Kick] kick Kick details
    #
    # @!method tree_query(query)
    #   Retrieve a representation of the server's channel/user tree
    #
    #   @param [Tree::Query] query Tree request
    #   @return [Tree] Tree representation
    #
    # @!method bans_get(query)
    #   Get the ban list for a server
    #
    #   @param [Ban::Query] query Ban query
    #   @return [Ban::List] Server ban list
    # @!method bans_set(list)
    #   Set the ban list for a server
    #
    #   @param [Ban::List] list Ban list
    #
    # @!method acl_get(channel)
    #   Get the ACL for a channel
    #
    #   @param [Channel] channel Channel to retrieve ACL for
    #   @return [ACL::List] Channel ACLs
    # @!method acl_set(list)
    #   Set the ACL for the given channel
    #
    #   @param [ACL::List] list New ACLs
    # @!method acl_get_effective_permissions(query)
    #   Get effective permissions for a given user in a given channel
    #
    #   @param [ACL::Query] query Query
    #   @return [ACL] Effective permissions
    # @!method acl_add_temporary_group(temporary_group)
    #   Add a user to a temporary group
    #
    #   @param [ACL::TemporaryGroup] temporary_group Temporary group
    # @!method acl_remove_temporary_group(temporary_group)
    #   Remove a user from a temporary group
    #
    #   @param [ACL::TemporaryGroup] temporary_group Temporary group
    #
    # @!method authenticator_stream(response)
    #   Open an authentication stream to the server.
    #
    #   There can be at most one RPC client with an open authentication stream.
    #   If a new authenticator connectes, the existing authentiction stream will be closed.
    #
    #   @param [Enumerable<Authenticator::Response>] response Response stream
    #   @return [Enumerable<Authenticator::Request>] Request stream
    #
    # @!method database_user_query(query)
    #   Retrieve a list of registered users matching the given query
    #
    #   @param [DatabaseUser::Query] query Query
    #   @return [DatabaseUser::List] Matching database users
    # @!method database_user_get(database_user)
    #   Get details for a database user given a user ID
    #
    #   @param [DatabaseUser] database_user Database user message with ID filled
    #   @return [DatabaseUser] Completed database user message
    # @!method database_user_update(database_user)
    #   Update a database user.
    #
    #   @param [DatabaseUser] database_user Database user to update
    #   @return [DatabaseUser] Updated database user
    # @!method database_user_register(database_user)
    #   Registers a user with the given information on the server.
    #   The returned {DatabaseUser} will contain the newly registered
    #   user's ID.
    #
    #   @param [DatabaseUser] database_user User details for registration
    #   @return [DatabaseUser] Registered database user
    # @!method database_user_deregister(database_user)
    #   De-register the given user
    #
    #   @param [DatabaseUser] database_user User to de-register
    # @!method database_user_verify(verify)
    #   Verify a user-password pair
    #
    #   @param [DatabaseUser::Verify] verify User-password pair
    #   @return [DatabaseUser] If the given pair is valid, the matching user is returned. Otherwise `nil`.
    #
    # @!method redirect_whisper_group_add(redirect_whisper_group)
    #   Add a whisper target redirection for the given user.
    #   Whenever the user whispers to the group `source`, the whisper
    #   will be redirected to the group `target`.
    #
    #   @param [RedirectWhisperGroup] redirect_whisper_group Redirection parameters
    # @!method redirect_whisper_group_remove(redirect_whisper_group)
    #   Remove a whisper target redirection.
    #
    #   @param [RedirectWhisperGroup] redirect_whisper_group Redirection group to remove
    class Stub; end
  end
end # module MurmurRPC

# rubocop:enable Naming/ConstantName, Lint/UnreachableCode
