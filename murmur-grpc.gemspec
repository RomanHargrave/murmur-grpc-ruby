# frozen_string_literal: true

Gem::Specification.new do |g|
  g.name = 'murmur-grpc'
  g.version = '0.0.2'
  g.licenses = ['GPL-3.0']
  g.summary = 'Murmur gRPC bindings for Ruby'
  g.description = 'Provides Murmur gRPC bindings for Ruby'
  g.authors = ['Roman Hargrave']
  g.homepage = 'https://github.com/RomanHargrave/murmur-grpc-ruby'
  g.metadata = {
    'source_code_uri' => 'https://github.com/RomanHargrave/murmur-grpc-ruby.git',
    'bug_tracker_uri' => 'https://github.com/RomanHargrave/murmur-grpc-ruby/issues'
  }
  g.email = 'roman@hargrave.info'
  g.files = %w[
          lib/murmur_rpc.rb
          lib/murmur_rpc/murmur_rpc_pb.rb
          lib/murmur_rpc/murmur_rpc_services_pb.rb
  ]
  g.add_runtime_dependency 'grpc', '~> 1.32'
end
