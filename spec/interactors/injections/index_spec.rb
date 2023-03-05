require "rails_helper"

RSpec.describe Injections::Index do
  let!(:patients) { create_list(:patient, 2) }
  let(:p1_injections) { create_list(:injection, 3, patient: patients[0]) }
  let(:p2_injections) { create_list(:injection, 3, patient: patients[1]) }

  context "without any filters" do
    subject(:index_context) do
      described_class.call
    end

    it "succeeds" do
      expect(index_context).to be_a_success
    end

    it "returns all injections" do
      result = index_context
      expect(result.injections).to eq(Injection.all.order(created_at: :desc))
    end
  end

  context "with patient_id" do
    subject(:index_context) do
      described_class.call(patient_id: patients[0].id)
    end

    it "succeeds" do
      expect(index_context).to be_a_success
    end

    it "returns only selected patient injections" do
      result = index_context
      expect(result.injections).to eq(p1_injections)
    end
  end
end

