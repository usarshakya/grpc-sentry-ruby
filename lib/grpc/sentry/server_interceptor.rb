# frozen_string_literal: true

module Grpc
  module Sentry
    ##
    # Intercepts inbound calls to provide Sentry error reporting
    #
    class ServerInterceptor < Grpc::Interceptors
      include Gruf::Sentry::ErrorParser

      ##
      # Handle the gruf around hook and capture errors
      #
      def call(&_block)
        begin
          yield
        rescue StandardError, GRPC::BadStatus => e
          if error?(e) # only capture
            ::Sentry.configure_scope do |scope|
              scope.set_transaction_name(request.service_key)
              scope.set_tags(grpc_method: request.method_key,
                             grpc_request_class: request.request_class.name,
                             grpc_service_key: request.service_key,
                             grpc_error_code: code_for(e),
                             grpc_error_class: e.class.name)
            end
            ::Sentry.capture_exception(e)
          end
          raise # passthrough
        end
      end

      private

      ##
      # @return [Hash]
      #
      def request_message_params
        return {} if request.client_streamer? || !request.message.respond_to?(:to_h)

        request.message.to_h
      end
    end
  end
end
