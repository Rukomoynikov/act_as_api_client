# frozen_string_literal: true

module ActAsApiClient
  module Errors
    class NonExistingClient < StandardError
      def initialize(requested_client:)
        @requested_client = requested_client
        super
      end

      def message
        "The requested client (#{@requested_client}) doesn't exist"
      end
    end
  end
end
