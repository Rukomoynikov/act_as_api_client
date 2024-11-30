# frozen_string_literal: true

require "act_as_api_client/clients/financial_modeling_prep/company_search_client"
require "act_as_api_client/errors/non_existing_client_error"

# rubocop:disable RSpec/ExampleLength
RSpec.describe ActAsApiClient::Clients::FinancialModelingPrep::CompanySearchClient do
  describe "search companies", vcr: true do
    let(:api_client) do
      Class.new(ApiClient) do
        act_as_api_client for: %i[financial_modeling_prep company_search],
                          with: { apikey: YAML.load_file("spec/credentials.yml").dig("financial_modeling_prep", "company_search", "apikey") } # rubocop:disable Layout/LineLength
      end
    end

    context "when params are valid" do
      it "sends request" do
        response = api_client.new.search(query: "AAPL")

        # rubocop:disable Layout/LineLength
        expect(
          response
        ).to eq(
          [
            { "symbol" => "AAPL", "name" => "Apple Inc.", "currency" => "USD", "stockExchange" => "NASDAQ Global Select", "exchangeShortName" => "NASDAQ" },
            { "symbol" => "AAPL.L", "name" => "LS 1x Apple Tracker ETC", "currency" => "GBp", "stockExchange" => "London Stock Exchange", "exchangeShortName" => "LSE" },
            { "symbol" => "AAPL.NE", "name" => "Apple Inc.", "currency" => "CAD", "stockExchange" => "NEO", "exchangeShortName" => "NEO" },
            { "symbol" => "AAPL.MX", "name" => "Apple Inc.", "currency" => "MXN", "stockExchange" => "Mexico", "exchangeShortName" => "MEX" },
            { "symbol" => "AAPL.DE", "name" => "15994", "currency" => "EUR", "stockExchange" => "Frankfurt Stock Exchange", "exchangeShortName" => "XETRA" },
            { "symbol" => "AAPLUSTRAD.BO", "name" => "AA Plus Tradelink Limited", "currency" => "INR", "stockExchange" => "Bombay Stock Exchange", "exchangeShortName" => "BSE" },
            { "symbol" => "HARIAAPL.BO", "name" => "Haria Apparels Limited", "currency" => "INR", "stockExchange" => "Bombay Stock Exchange", "exchangeShortName" => "BSE" },
            { "symbol" => "APLY.NE", "name" => "Apple (AAPL) Yield Shares Purpose ETF", "currency" => "CAD", "stockExchange" => "Cboe CA", "exchangeShortName" => "NEO" },
            { "symbol" => "APLY", "name" => "YieldMax AAPL Option Income Strategy ETF", "currency" => "USD", "stockExchange" => "New York Stock Exchange Arca", "exchangeShortName" => "AMEX" },
            { "symbol" => "AAPD", "name" => "Direxion Daily AAPL Bear 1X Shares", "currency" => "USD", "stockExchange" => "NASDAQ Global Market", "exchangeShortName" => "NASDAQ" }
          ]
        )
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
# rubocop:enable RSpec/ExampleLength
