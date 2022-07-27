# frozen_string_literal: true

require "act_as_api_client/clients/authorize_net_webhooks_client"

RSpec.describe ActAsApiClient::Clients::AuthorizeNetWebhooksClient do
  let(:authorize_net_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :authorize_net_webhooks,
                        with: {
                          mode: :test,
                          payment_user: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_user"),
                          payment_pass: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_pass")
                        }
    end
  end

  describe "#find", vcr: true do
    context "when options are valid" do
      it "returns detailed info about one webhook" do
        expect(
          authorize_net_class.new.find("f8ea19aa-1728-4601-bfe5-8f580456ce89")
        ).to include({ "webhookId" => "f8ea19aa-1728-4601-bfe5-8f580456ce89" })
      end
    end
  end
end
