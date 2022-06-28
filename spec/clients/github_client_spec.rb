# frozen_string_literal: true

require 'act_as_api_client/clients/github_client'
require 'act_as_api_client'

RSpec.describe ActAsApiClient::Clients::GithubClient do
  let(:github_client) {
    class GithubClient < ApiClient
      act_as_api_client for: :github,
                        with: {
                          token: YAML.load_file('spec/credentials.yml').dig('github', 'token')
                        }
    end

    GithubClient.new
  }

  context 'when correct options are provided', :vcr do
    it 'returns list of repositories (#find)' do
      expect(github_client.find).to be_a_kind_of(Array)
    end
  end
end
