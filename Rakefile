# frozen_string_literals: true

require 'bundler'

BASEDIR = File.dirname(__FILE__)

task :proto do
  sh %{bundle exec grpc_tools_ruby_protoc -I #{BASEDIR}/definitions/ --ruby_out=#{BASEDIR}/lib --grpc_out=#{BASEDIR}/lib #{BASEDIR}/definitions/murmur_rpc/murmur_rpc.proto}
end

task build: %w[proto] do
  sh %{gem build}
end

task default: %w[build]

task :clean do
  rm 'lib/murmur_rpc/murmur_rpc_pb.rb'
  rm 'lib/murmur_rpc/murmur_rpc_services_pb.rb'
end
