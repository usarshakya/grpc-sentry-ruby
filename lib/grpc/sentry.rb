# frozen_string_literal: true

require 'grpc'
require 'sentry-ruby'
# backwards-compatibly patch for sentry-raven users
::Raven = ::Sentry unless defined?(::Raven)

require_relative 'sentry/configuration'
require_relative 'sentry/error_parser'
require_relative 'sentry/server_interceptor'

##
# Base grpc module
#
module Grpc
  ##
  # Base grpc-sentry-ruby module
  #
  module Sentry
    extend Grpc::Sentry::Configuration
  end
end
