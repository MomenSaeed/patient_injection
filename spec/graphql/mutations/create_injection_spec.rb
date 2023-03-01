require "rails_helper"

RSpec.describe Mutations::CreateInjection, type: :request do
  let(:patient) { create(:patient) }
  let(:input) do
    {
      injection: {
        dose:      2.0,
        drugName:  "drug 1",
        lotNumber: "anynum",
      },
    }
  end

  describe "requesting query from interactor" do
    let(:injection_create) { double("injections_create", success?: true, injection: Injection.last) }

    it "uses Injections::Create interactor" do
      allow(Injections::Create).to receive(:call).and_return(injection_create)
      graphql_query(query:, variables: { input: }, api_key: patient.api_key)
      graphql_data("data", "createInjection", "injection")
      expect(Injections::Create).to have_received(:call).once
    end
  end

  it "creates new patient" do
    graphql_query(query:, variables: { input: }, api_key: patient.api_key)

    expect(graphql_data("data", "createInjection", "injection")).to match(
      {
        id:        Injection.last.id,
        dose:      2.0,
        drugName:  "drug 1",
        lotNumber: "anynum",
      }.with_indifferent_access
    )
  end

  def query
    <<~GQL
      mutation createInjection($input: CreateInjectionInput!) {
        createInjection(input:$input) {
          injection {
            id
            dose
            drugName
            lotNumber
          }
        }
      }
    GQL
  end
end

