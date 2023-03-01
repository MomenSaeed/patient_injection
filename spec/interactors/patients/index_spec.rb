require "rails_helper"

RSpec.describe Patients::Index do
  subject(:index_context) do
    described_class.call
  end

  let(:patients) { create_list(:patient, 2) }

  it "succeeds" do
    expect(index_context).to be_a_success
  end

  it "returns all patients" do
    result = index_context
    expect(result.patients).to eq(Patient.all)
  end
end

