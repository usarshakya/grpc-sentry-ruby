# frozen_string_literal: true

module Gruf
  module Interceptors
    ##
    # Intercepts server requests
    #
    class ServerInterceptor < Base

      ##
      # Call the interceptor
      #
      def call
        binding.pry
      end
    end
  end
end