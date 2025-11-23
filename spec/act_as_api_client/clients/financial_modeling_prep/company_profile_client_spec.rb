# frozen_string_literal: true

require "act_as_api_client/clients/financial_modeling_prep/company_profile_client"
require "act_as_api_client/errors/non_existing_client_error"

# rubocop:disable RSpec/ExampleLength
RSpec.describe ActAsApiClient::Clients::FinancialModelingPrep::CompanyProfileClient do
  describe "search companies", vcr: true do
    let(:api_client) do
      Class.new(ApiClient) do
        act_as_api_client for: %i[financial_modeling_prep company_profile],
                          with: { apikey: YAML.load_file("spec/credentials.yml").dig("financial_modeling_prep", "company_search", "apikey") } # rubocop:disable Layout/LineLength
      end
    end

    context "when params are valid" do
      it "sends request" do
        response = api_client.new.search(ticker: "AAPL")

        # rubocop:disable Layout/LineLength,
        expect(
          response[0]
        ).to eq(
          {
            "symbol" => "AAPL",
            "price" => 237.33,
            "beta" => 1.24,
            "volAvg" => 48_873_433,
            "mktCap" => 3_587_432_814_000,
            "lastDiv" => 0.99,
            "range" => "164.08-237.81",
            "changes" => 2.4,
            "companyName" => "Apple Inc.",
            "currency" => "USD",
            "cik" => "0000320193",
            "isin" => "US0378331005",
            "cusip" => "037833100",
            "exchange" => "NASDAQ Global Select",
            "exchangeShortName" => "NASDAQ",
            "industry" => "Consumer Electronics",
            "website" => "https://www.apple.com",
            "description" => "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, and HomePod. It also provides AppleCare support and cloud services; and operates various platforms, including the App Store that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Fitness+, a personalized fitness service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It distributes third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1976 and is headquartered in Cupertino, California.",
            "ceo" => "Mr. Timothy D. Cook",
            "sector" => "Technology",
            "country" => "US",
            "fullTimeEmployees" => "164000",
            "phone" => "408 996 1010",
            "address" => "One Apple Park Way",
            "city" => "Cupertino",
            "state" => "CA",
            "zip" => "95014",
            "dcfDiff" => 82.03306,
            "dcf" => 155.29693509599323,
            "image" => "https://images.financialmodelingprep.com/symbol/AAPL.png",
            "ipoDate" => "1980-12-12",
            "defaultImage" => false,
            "isEtf" => false,
            "isActivelyTrading" => true,
            "isAdr" => false,
            "isFund" => false
          }
        )
        # rubocop:enable Layout/LineLength
      end
    end
  end
end
# rubocop:enable RSpec/ExampleLength
