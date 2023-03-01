require "rails_helper"

RSpec.describe Patients::Details do
  let(:patient) { create(:patient) }

  context "when patient exists" do
    subject(:details_context) do
      described_class.call(patient_id: patient.id)
    end

    it "succeeds" do
      expect(details_context).to be_a_success
    end

    it "returns needed patient" do
      result = details_context
      expect(result.patient).to eq(patient)
    end
  end

  context "when patient_id is invalid" do
    subject(:details_context) do
      described_class.call(patient_id: "")
    end

    it "returns nil" do
      result = details_context
      expect(result.patient).to be_nil
    end
  end
end

