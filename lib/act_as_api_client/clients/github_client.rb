# frozen_string_literal: true

require_relative "http_client"

module ActAsApiClient
  module Clients
    module GithubClient
      include HttpClient
      def find(repository_name)
        unless repository_name.match?(%r{[a-zA-Z]/[a-zA-Z]})
          raise StandardError, "repository_name parameter is not valid"
        end

        get("https://api.github.com/repos/#{repository_name}",
            headers: { "Accept" => "application/vnd.github.v3+json",
                       "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) })
      end

      def where(query_string, parameters = {})
        get("https://api.github.com/search/repositories",
            headers: { "Accept" => "application/vnd.github.v3+json",
                       "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) },
            params: { q: query_string }.merge(parameters))
      end

      def find_by(options = {})
        unless options.is_a?(Hash)
          raise StandardError, "provide a hash as an argument not #{options.class.to_s.downcase}"
        end
        raise StandardError, "provide at least one parameter" if options.keys.length.zero?
        raise StandardError, "method 'find_by' supports only one parameter" if options.keys.length > 1

        url = case options.keys.first
              when :organization
                "https://api.github.com/orgs/#{options[:organization]}/repos"
              when :user
                "https://api.github.com/users/#{options[:user]}/repos"
              when :authenticated_user
                "https://api.github.com/repositories"
              end

        get(url,
            headers: { "Accept" => "application/vnd.github.v3+json",
                       "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) })
      end

      def delete
        # Call only on queried before repository and repository is not 404/400 and has right to delete (write)
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
