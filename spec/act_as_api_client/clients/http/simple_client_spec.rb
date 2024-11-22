# frozen_string_literal: true

require "act_as_api_client/clients/http/simple_client"

RSpec.describe ActAsApiClient::Clients::Http::SimpleClient do
  let(:github_client_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :github_repositories, with: { token: "token1" }
    end
  end

  it "calls method from inherited class option 'for' is provided", :vcr do
    expect { github_client_class.new.find("Rukomoynikov/tabled") }.not_to raise_error
  end
end
