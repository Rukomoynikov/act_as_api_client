# frozen_string_literal: true

require_relative "http_client"
require 'httparty'

module ActAsApiClient
  module Clients
    module GithubClient
      include HttpClient
      def find
        HTTParty.get('https://api.github.com/repositories', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/vnd.github.v3+json' }).parsed_response

        # get(, {
        #
        # })
      end

      def where
        "where"
      end

      def find_by
        "find_by"
      end

      def delete
        "delete"
      end

      def create
        "create"
      end

      def update
        "update"
      end
    end
  end
end
