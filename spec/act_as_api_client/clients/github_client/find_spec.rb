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

  describe "#find", vcr: true do
    context "when options are invalid" do
      it "raises an exception" do
        expect do
          github_client_class.new.find("Rukomoynikovtabled")
        end.to raise_error(StandardError, "repository_name parameter is not valid")
      end

      it "returns 'Not found' messages" do
        expect(
          github_client_class.new.find("Rukomoynikov/tabled111")
        ).to include({ "message" => "Not Found" })
      end
    end

    context "when options invalid" do
      it "returns detailed info about one repository" do
        expect(
          github_client_class.new.find("Rukomoynikov/tabled")
        ).to include({ "full_name" => "Rukomoynikov/tabled" })
      end

      it "returns detailed info about one private repository using token" do
        expect(
          github_client_class.new.find("Rukomoynikov/heroes-of-markets")
        ).to include({ "full_name" => "Rukomoynikov/heroes-of-markets" })
      end
    end
  end
end
