require "rails_helper"

RSpec.describe Resolvers::Injections::Details, type: :request do
  let(:patient) { create(:patient) }
  let(:injection) { create(:injection, patient:) }

  describe "requesting query from interactor" do
    let(:injection_details) { instance_double(Injections::Details, injection:) }

    it "uses Injections::Details interactor" do
      allow(Injections::Details).to receive(:call).and_return(injection_details)
      graphql_query(query:, variables: { id: injection.id }, api_key: patient.api_key)
      graphql_data("data", "injection")
      expect(Injections::Details).to have_received(:call).once.with(injection_id: injection.id)
    end
  end

  it "returns requested injection data" do
    graphql_query(query:, variables: { id: injection.id }, api_key: patient.api_key)

    expect(graphql_data("data", "injection")).to match(
      {
        id:        injection.id,
        dose:      injection.dose,
        lotNumber: injection.lot_number,
        drugName:  injection.drug_name,
      }.with_indifferent_access
    )
  end

  def query
    <<~GQL
      query injection($id: ID!) {
        injection(id: $id) {
          id
          dose
          lotNumber
          drugName
        }
      }
    GQL
  end
end

