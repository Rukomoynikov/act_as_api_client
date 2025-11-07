# frozen_string_literal: true

require "act_as_api_client/clients/http/simple_client"

RSpec.describe ActAsApiClient::Clients::Http::SimpleClient do
  let(:simple_client) { subject }

  context "when network is not available", vcr: { allow_unused_http_interactions: true } do
    it "returns correct error" do
      %i[get post].each do |method|
        expect do
          simple_client.send(method, "https://thisurldoesnexisthahaha")
        end.to raise_error(ActAsApiClient::Errors::NetworkError)
      end
    end
  end
end
