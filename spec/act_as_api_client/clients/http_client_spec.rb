# frozen_string_literal: true

require "act_as_api_client"

RSpec.describe ActAsApiClient::Clients::HttpClient do
  let(:github_client_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :github, with: { token: "token1" }
    end
  end

  context "when GithubClient" do
    it "responds to all http methods" do
      methods = %i[get put delete post update]

      expect(github_client_class.new).to respond_to(*methods)
    end
  end

  it "calls method from inherited class option 'for' is provided", :vcr do
    expect { github_client_class.new.find("Rukomoynikov/tabled") }.not_to raise_error
  end
end
