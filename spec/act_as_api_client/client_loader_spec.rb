# frozen_string_literal: true

require "act_as_api_client/client_loader"

RSpec.describe ActAsApiClient::ClientLoader do
  let(:client_loader) { described_class }

  context "when client is string" do
    let(:client) { "github_repositories" }
    let(:cl) { client_loader.new(client_for: client) }

    it "returns correct class name" do
      expect(cl.class_name).to eq("GithubRepositoriesClient")
    end

    it "returns correct path" do
      expect(cl.path).to end_with("act_as_api_client/clients/github_repositories_client")
    end
  end

  context "when client is array" do
    let(:client) { %i[anthropic messages] }
    let(:cl) { client_loader.new(client_for: client) }

    it "returns correct class name" do
      expect(cl.class_name).to eq("Anthropic::MessagesClient")
    end

    it "returns correct path" do
      expect(cl.path).to end_with("act_as_api_client/clients/anthropic/messages_client")
    end
  end
end
