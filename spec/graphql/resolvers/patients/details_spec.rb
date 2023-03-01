require "rails_helper"

RSpec.describe Resolvers::Patients::Details, type: :request do
  let(:patient) { create(:patient) }

  describe "requesting query from interactor" do
    let(:patient_details) { instance_double(Patients::Details, patient:) }

    it "uses Patients::Details interactor" do
      allow(Patients::Details).to receive(:call).and_return(patient_details)
      graphql_query(query:, api_key: patient.api_key)
      graphql_data("data", "currentPatient")
      expect(Patients::Details).to have_received(:call).once.with(patient_id: patient.id)
    end
  end

  it "returns current patient data" do
    graphql_query(query:, api_key: patient.api_key)

    expect(graphql_data("data", "currentPatient")).to match(
      {
        id:       patient.id,
        apiKey:   patient.api_key,
        fullName: patient.full_name,
      }.with_indifferent_access
    )
  end

  def query
    <<~GQL
      query patient {
        currentPatient {
          id
          apiKey
          fullName
        }
      }
    GQL
  end
end

