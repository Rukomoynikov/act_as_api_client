# frozen_string_literal: true

require "act_as_api_client/clients/http/simple_client"

# More docs on https://site.financialmodelingprep.com/developer/docs#general-search-company-search

module ActAsApiClient
  module Clients
    module FinancialModelingPrep
      module CompanyProfileClient
        BASE_URL = "https://financialmodelingprep.com/api/v3/profile"

        def search(ticker:)
          client = ActAsApiClient::Clients::Http::SimpleClient.new

          client.get("#{BASE_URL}/#{ticker}",
                     headers: headers,
                     params: {
                       apikey: options[:apikey]
                     })
        end

        private

        def headers
          { "Content-Type": "application/json" }
        end
      end
    end
  end
end
