require "rails_helper"

RSpec.describe Resolvers::Patients::Index, type: :request do
  let(:patients) { create_list(:patient, 10) }

  describe "requesting query from interactor" do
    let(:patient_index) { instance_double(Patients::Index, patients:) }

    it "uses Patients::Details interactor" do
      allow(Patients::Index).to receive(:call).and_return(patient_index)
      graphql_query(query:, api_key: patients[0].api_key)
      graphql_data("data", "patientsConnection")
      expect(Patients::Index).to have_received(:call).once
    end
  end

  it "returns paginated patients connection" do
    graphql_query(query:, api_key: patients[0].api_key)

    expect(graphql_data("data", "patientsConnection")["nodes"].size).to eq(4)
  end

  def query
    <<~GQL
      query patients {
        patientsConnection(first: 4) {
          nodes {
            id
            fullName
            apiKey
          }
          pageInfo {
            endCursor
            startCursor
            hasNextPage
            hasPreviousPage
            startCursor
          }
          totalCount
          count
        }
      }
    GQL
  end
end

