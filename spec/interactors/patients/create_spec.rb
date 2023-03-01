require "rails_helper"

RSpec.describe Patients::Create do
  context "when full name is valid" do
    subject(:create_context) do
      described_class.call(full_name: Faker::Name.name)
    end

    it "succeeds" do
      expect(create_context).to be_a_success
    end

    it "creats new Patient" do
      result = create_context
      expect(result.patient).to eq(Patient.first)
    end
  end

  context "when full name is invalid" do
    subject(:create_context) do
      described_class.call(full_name: "")
    end

    it "fails" do
      expect(create_context).to be_a_failure
    end

    it "creats new Patient" do
      result = create_context
      expect(result.errors.full_messages).to eq(["Full name can't be blank"])
    end
  end
end

