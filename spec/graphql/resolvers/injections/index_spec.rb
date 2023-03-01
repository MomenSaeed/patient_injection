require "rails_helper"

RSpec.describe Resolvers::Injections::Index, type: :request do
  let(:patient) { create(:patient) }
  let(:injections) { create_list(:injection, 10, patient:) }

  describe "requesting query from interactor" do
    let(:injection_index) { instance_double(Injections::Index, injections:) }

    it "uses Injections::Details interactor" do
      allow(Injections::Index).to receive(:call).and_return(injection_index)
      graphql_query(query:, api_key: patient.api_key)
      graphql_data("data", "injectionsConnection")
      expect(Injections::Index).to have_received(:call).with(patient_id: patient.id).once
    end
  end

  it "returns paginated patients connection" do
    injections
    graphql_query(query:, api_key: patient.api_key)

    expect(graphql_data("data", "injectionsConnection")["nodes"].size).to eq(4)
  end

  def query
    <<~GQL
      query injections {
        injectionsConnection(first:  4) {
          nodes {
            id
            dose
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

