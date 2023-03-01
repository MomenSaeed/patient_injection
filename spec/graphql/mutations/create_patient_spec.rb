require "rails_helper"

RSpec.describe Mutations::CreatePatient, type: :request do
  let(:input) { { fullName: Faker::Name.name } }

  describe "requesting query from interactor" do
    let(:patient_create) { double("patients_create", success?: true, patient: Patient.last) }

    it "uses Patients::Create interactor" do
      allow(Patients::Create).to receive(:call).and_return(patient_create)
      graphql_query(query:, variables: { input: })
      graphql_data("data", "createPatient", "patient")
      expect(Patients::Create).to have_received(:call).once.with(full_name: input[:fullName])
    end
  end

  it "creates new patient" do
    graphql_query(query:, variables: { input: })

    expect(graphql_data("data", "createPatient", "patient")).to match(
      {
        id:       Patient.first.id,
        apiKey:   Patient.first.api_key,
        fullName: Patient.first.full_name,
      }.with_indifferent_access
    )
  end

  def query
    <<~GQL
      mutation createPatient($input: CreatePatientInput!) {
        createPatient(input:$input) {
          patient {
            id
            apiKey
            fullName
          }
        }
      }
    GQL
  end
end

