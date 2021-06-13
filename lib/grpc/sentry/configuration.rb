# frozen_string_literal: true

module Grpc
  module Sentry
    ##
    # Configuration module for grpc-sentry-ruby
    #
    module Configuration
      VALID_CONFIG_KEYS = {
        grpc_error_classes: ::ENV.fetch(
          'GRUF_SENTRY_GRPC_ERROR_CLASSES',
          'GRPC::Unknown,GRPC::Internal,GRPC::DataLoss,GRPC::FailedPrecondition,GRPC::Unavailable,GRPC::DeadlineExceeded,GRPC::Cancelled'
        ).to_s.split(',').map(&:strip),
        default_error_code: ::ENV.fetch('GRUF_SENTRY_DEFAULT_ERROR_CODE', GRPC::Core::StatusCodes::INTERNAL).to_i
      }.freeze

      attr_accessor *VALID_CONFIG_KEYS.keys

      ##
      # Whenever this is extended into a class, setup the defaults
      #
      def self.extended(base)
        base.reset
      end

      ##
      # Yield self for ruby-style initialization
      #
      # @yields [Grpc::Sentry::Configuration]
      # @return [Grpc::Sentry::Configuration]
      #
      def configure
        yield self
      end

      ##
      # Return the current configuration options as a Hash
      #
      # @return [Hash]
      #
      def options
        opts = {}
        VALID_CONFIG_KEYS.each_key do |k|
          opts.merge!(k => send(k))
        end
        opts
      end

      ##
      # Set the default configuration onto the extended class
      #
      # @return [Hash] options The reset options hash
      #
      def reset
        VALID_CONFIG_KEYS.each do |k, v|
          send("#{k}=".to_sym, v)
        end

        options
      end
    end
  end
end
