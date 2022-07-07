# frozen_string_literal: true

require "act_as_api_client/clients/github_client"

RSpec.describe ActAsApiClient::Clients::GithubClient do
  let(:github_client_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :github,
                        with: {
                          token: YAML.load_file("spec/credentials.yml").dig("github", "token")
                        }
    end
  end

  context "when correct options are provided", :vcr do
    it "returns list of repositories (#find)" do
      expect(github_client_class.new.find("Rukomoynikov/tabled")).to include({ "full_name" => "Rukomoynikov/tabled" })
    end
  end
end
