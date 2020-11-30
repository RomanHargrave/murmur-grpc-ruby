# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

require_relative 'lifted/client'
require_relative 'lifted/context_action'
require_relative 'lifted/server'
require_relative 'lifted/user'

module MurmurRPC
  # High-Level wrapper interface for the Murmur gRPC Service
  #
  # @see Lifted::Client
  module Lifted
    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity

    # Extract identities from lifted messages
    #
    # @param [Enumerable] enumerable A collection of objects
    def extract_identities(enumerable)
      case enumerable
      when Hash
        enumerable.map do |k, v|
          v = case v
              when RemoteObject
                v.identity
              when Enumerable
                extract_identities(v)
              else
                v
              end
          [k, v]
        end.to_h
      else
        enumerable.map do |e|
          case e
          when RemoteObject
            e.identity
          when Enumerable
            extract_identities(e)
          else
            e
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
  end
end
