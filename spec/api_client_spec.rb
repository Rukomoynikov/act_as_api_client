# frozen_string_literal: true

RSpec.describe ApiClient do
  context "with provided options" do
    let(:github_client_class) do
      Class.new(ApiClient) do
        act_as_api_client for: :github, with: { token: "token1" }
      end
    end

    let(:github_client_class_2) do
      Class.new(ApiClient) do
        act_as_api_client for: :github, with: { token: "token2" }
      end
    end

    it "doesn't affect options from another instances" do
      gh1 = github_client_class.new
      gh2 = github_client_class_2.new

      expect([gh1.options[:token], gh2.options[:token]]).to eq(%w[token1 token2])
    end
  end
end
