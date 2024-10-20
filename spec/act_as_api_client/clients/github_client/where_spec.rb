# frozen_string_literal: true

require "act_as_api_client/clients/github_repositories_client"

RSpec.describe ActAsApiClient::Clients::GithubRepositoriesClient do
  let(:github_client_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :github_repositories,
                        with: {
                          token: YAML.load_file("spec/credentials.yml").dig("github", "token")
                        }
    end
  end

  describe "#where", vcr: true do
    context "when parameters invalid" do
      it "returns error when query is empty" do
        expect do
          github_client_class.new.where
        end.to raise_error(ArgumentError)
      end
    end

    context "when parameters are valid" do
      it "returns results when query_string is provided" do
        expect(github_client_class.new.where("tabled")).to include("items")
      end
    end

    context "when parameters are passed" do
      it "returns results when query_string is provided" do
        repositories_count = github_client_class
                             .new
                             .where("tabled", per_page: 100)["items"]
                             .count
        expect(repositories_count).to be(100)
      end
    end
  end
end
