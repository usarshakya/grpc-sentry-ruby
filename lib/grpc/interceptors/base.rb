# frozen_string_literal: true

module Grpc
  module Interceptors
    ##
    # Base class for interception requests
    #
    class Base
      # @var [Gruf::Controllers::Request] request
      attr_reader :request
      # @var [Gruf::Error] error
      attr_reader :error
      # @var [Hash] options
      attr_reader :options

      ##
      # @param [Gruf::Controllers::Request] request
      # @param [Gruf::Error] error
      # @param [Hash] options
      #
      def initialize(request, error, options = {})
        @request = request
        @error = error
        @options = options || {}
      end
    end
  end
end

require_relative 'server_interceptor'
