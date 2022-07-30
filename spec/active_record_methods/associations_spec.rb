# frozen_string_literal: true

require "act_as_api_client/clients/authorize_net_notifications_client"
# require "act_as_api_client/clients/authorize_net_notifications_client"

RSpec.describe 'Associations', vcr: true do
  context "has_many" do
    let(:authorize_net_webhooks_client_class) do
      Class.new(ApiClient) do
        has_many :notifications, class_name: ActAsApiClient::Clients::AuthorizeNetNotificationsClient

        act_as_api_client for: :authorize_net_webhooks,
                          with: {
                            mode: :test,
                            payment_user: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_user"),
                            payment_pass: YAML.load_file("spec/credentials.yml").dig("authorize", "payment_pass")
                          }
      end
    end

    it 'supports has_many method' do
      expect { authorize_net_webhooks_client_class.new }.not_to raise_error
    end

    it 'returns list of notifications' do
      authorize_net_webhooks_client_class.new
                                         .find("f8ea19aa-1728-4601-bfe5-8f580456ce89")
                                         .notifications
    end
  end
end