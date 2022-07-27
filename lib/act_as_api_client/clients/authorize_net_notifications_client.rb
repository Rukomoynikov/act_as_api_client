# frozen_string_literal: true

require_relative "http_client"
require_relative "./authorize_net_webhooks_client"
require "base64"

module ActAsApiClient
  module Clients
    module AuthorizeNetNotificationsClient
      include AuthorizeNetWebhooksClient

      def where(parameters = {})
        # GET https://apitest.authorize.net/rest/v1/notifications?from_date=2017-03-01&to_date=2017-03-13&offset=0&limit=100
        # GET https://apitest.authorize.net/rest/v1/notifications?deliveryStatus=Failed
        # [:from_date, :to_date, :offset, :limit, :deliveryStatus]

        get("https://#{base_uri}/rest/v1/notifications/",
            headers: { "Authorization" => auth },
            params: parameters)
      end

      def find(uuid)
        raise StandardError, "uuid is not provided" if uuid.empty?

        get("https://#{base_uri}/rest/v1/notifications/#{uuid}",
            headers: { "Authorization" => auth })
      end
    end
  end
end
