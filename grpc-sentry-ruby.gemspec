# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'grpc-sentry-ruby'
  spec.version       = '0.1.0'
  spec.authors       = ['Rasna Shakya']
  spec.email         = ['rasnashakya@gmail.com']

  spec.summary       = %q{Automatically report grpc failures as sentry errors}
  spec.description   = spec.summary

  spec.required_ruby_version = '>=3.0'

  spec.files         = Dir['lib/**/*', 'grpc-sentry-ruby.gemspec']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '>= 13.0.3'
  spec.add_development_dependency 'pry', '~> 0.14.1'

  spec.add_dependency 'grpc', '~> 1.38'
  spec.add_dependency 'sentry-ruby', '~> 4.5'
end
