# frozen_string_literal: true

require "httparty"

module ActAsApiClient
  module Clients
    module HttpClient
      def get
        HTTParty.get
      end

      def post
        HTTParty.post
      end

      def put
        HTTParty.put
      end

      def update
        HTTParty.update
      end

      def delete
        HTTParty.delete
      end
    end
  end
end
