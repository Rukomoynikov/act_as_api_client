# frozen_string_literal: true

require "act_as_api_client/clients/authorize_net_notifications_client"

RSpec.describe ActAsApiClient::Clients::AuthorizeNetNotificationsClient do
  let(:authorize_net_class) do
    Class.new(ApiClient) do
      act_as_api_client for: :authorize_net_notifications,
                        with: {
                          mode: :test,
                          payment_user: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_user"),
                          payment_pass: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_pass")
                        }
    end
  end

  describe "#where", vcr: true do
    context "when options are valid" do
      it "returns info about recent webhooks" do
        expect(
          authorize_net_class.new.where(from_date: "2022-07-27")
        ).to have_key("_links")
      end
    end
  end

  describe "#find", vcr: true do
    context "when options are valid" do
      it "returns info about one particular notification" do
        expect(
          authorize_net_class.new.find("1a652bd4-30d8-4124-af83-0722672d1c37")
        ).to include({ "webhookId" => "f8ea19aa-1728-4601-bfe5-8f580456ce89" })
      end
    end
  end
end
