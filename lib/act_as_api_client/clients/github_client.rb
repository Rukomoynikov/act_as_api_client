# frozen_string_literal: true

require_relative "http_client"

module ActAsApiClient
  module Clients
    module GithubClient
      include HttpClient
      def find
        get('https://api.github.com/repositories', {
          headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
        })
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
