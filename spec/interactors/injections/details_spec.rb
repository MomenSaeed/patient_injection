require "rails_helper"

RSpec.describe Injections::Details do
  let!(:patient) { create(:patient) }
  let(:injection) { create(:injection, patient:) }

  context "when injection exists" do
    subject(:details_context) do
      described_class.call(injection_id: injection.id)
    end

    it "succeeds" do
      expect(details_context).to be_a_success
    end

    it "returns needed injection" do
      result = details_context
      expect(result.injection).to eq(injection)
    end
  end

  context "when injection_id is invalid" do
    subject(:details_context) do
      described_class.call(injection_id: "")
    end

    it "returns nil" do
      result = details_context
      expect(result.injection).to be_nil
    end
  end
end

