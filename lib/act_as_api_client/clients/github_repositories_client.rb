# frozen_string_literal: true

require_relative "http_client"

module ActAsApiClient
  module Clients
    module GithubRepositoriesClient
      include HttpClient

      # Searches Github for one repository by it's owner and repository names.
      # More details look at the corresponding {https://docs.github.com/en/rest/repos/repos#get-a-repository Github Docs page}
      #
      # @param repository_name [String] owner and repository name, 'Rukomoynikov/tabled'
      #
      # @return [Hash] detailed info about the repository.
      def find(repository_name)
        unless repository_name.match?(%r{[a-zA-Z]/[a-zA-Z]})
          raise StandardError, "repository_name parameter is not valid"
        end

        get("https://api.github.com/repos/#{repository_name}",
            headers: { "Accept" => "application/vnd.github.v3+json",
                       "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) })
      end

      # Search through Github repositories using query string and additional parameters explained on the {https://docs.github.com/en/rest/search#search-repositories Github Docs page}
      #
      # @param query_string [String] query string to search github repositories
      # @param parameters [Hash] paramaters like per_page, page, sort and order
      #
      # @example Reverse a string
      #   class GithubClient < ApiClient
      #     act_as_api_client for: :github
      #   end
      #
      #   GithubClient.new.where('rails')
      #   GithubClient.new.where('rails', per_page: 100)
      #
      # @return [Array] list of repositories
      def where(query_string, parameters = {})
        get("https://api.github.com/search/repositories",
            headers: { "Accept" => "application/vnd.github.v3+json",
                       "Authorization" => (options[:token] ? "token #{options[:token]}" : nil) },
            params: { q: query_string }.merge(parameters))
      end

      # Use this method if you need to get list of repositories selected by one of this conditions: user, authenticated_user, organization
      #
      # @param options [Hash] has to have one of these keys: user, authenticated_user, organization
      #
      # @example Reverse a string
      #   class GithubClient < ApiClient
      #     act_as_api_client for: :github
      #   end
      #
      #   GithubClient.new.find_by(organization: 'rails')
      #
      # @return [Array] list of repositories
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

      # def delete
      #   # Call only on queried before repository and repository is not 404/400 and has right to delete (write)
      #   "delete"
      # end
      #
      # def create
      #   "create"
      # end
      #
      # def update
      #   "update"
      # end
    end
  end
end
