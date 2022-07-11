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

  describe "#find_by", vcr: true do
    context "when options are invalid" do
      it "checks type of argument" do
        expect do
          github_client_class.new.find_by("Rukomoynikovtabled")
        end.to raise_error(StandardError, "provide a hash as an argument not string")
      end

      it "checks options length to be > 1" do
        expect do
          github_client_class.new.find_by({})
        end.to raise_error(StandardError, "provide at least one parameter")
      end

      it "checks options length to be < 2" do
        expect do
          github_client_class.new.find_by({ a: 1, b: 2 })
        end.to raise_error(StandardError, "method 'find_by' supports only one parameter")
      end
    end

    context "when options are valid" do
      describe "by_organization" do
        it "returns detailed info about one repository" do
          expect(
            github_client_class.new.find_by(organization: "rails")
          ).to be_a_kind_of(Array)
        end
      end

      describe "by_user" do
        it "returns detailed info about one repository" do
          expect(
            github_client_class.new.find_by(user: "RaulSeSo")
          ).to be_kind_of(Array)
        end
      end

      describe "by_authenticated_user" do
        it "returns detailed info about one repository" do
          expect(
            github_client_class.new.find_by(authenticated_user: "Rukomoynikov")
          ).to be_kind_of(Array)
        end
      end
    end
  end
end
