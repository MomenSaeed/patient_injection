require "rails_helper"

RSpec.describe Injections::Create do
  let!(:patient) { create(:patient) }
  let!(:injection) { build(:injection) }

  context "when input is valid" do
    subject(:create_context) do
      described_class.call(injection_params: injection.attributes, patient:)
    end

    it "succeeds" do
      expect(create_context).to be_a_success
    end

    it "creats new Injection" do
      result = create_context
      expect(result.injection).to eq(Injection.last)
    end
  end

  context "when input is invalid" do
    subject(:create_context) do
      described_class.call(injection_params: injection.attributes.except("dose"))
    end

    it "fails" do
      expect(create_context).to be_a_failure
    end

    it "creats new Patient" do
      result = create_context
      expect(result.errors.full_messages).to eq(["Dose can't be blank", "Patient must exist"])
    end
  end
end

