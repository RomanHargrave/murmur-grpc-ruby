# frozen_string_literal: true

# Murmur RPC client for Ruby
# (C) 2020- Roman Hargrave <roman@hargrave.info>
# Licensed under the GPL-3.0 - see LICENSE for more details

require_relative 'murmur_rpc/murmur_rpc_pb'
require_relative 'murmur_rpc/murmur_rpc_services_pb'

# Root namespace for the Murmur gRPC client
#
# @see MurmurRPC::Lifted
# @see MurmurRPC::V1::Stub
module MurmurRPC; end
