require "rails_helper"

RSpec.describe Resolvers::AdherenceScore, type: :request do
  let!(:patient) { create(:patient, created_at: DateTime.now - 30.days) }
  let(:injections) { create_list(:injection, 10, patient:) }

  describe "requesting query from interactor" do
    let(:addherence_score) { double("adherence_score", success?: true, result: score_result) }
    let(:score_result) do
      {
        adherenceScore:    0,
        expectedInjection: 0,
        actualInjection:   0,
        onTimeInjection:   0,
        injectionsGraph:   [],
      }
    end

    it "uses Adherence::Score, interactor" do
      allow(Adherence::Score).to receive(:call).and_return(addherence_score)

      graphql_query(query:, api_key: patient.api_key)
      graphql_data("data", "adherenceScore")

      expect(Adherence::Score).to have_received(:call).once
    end
  end

  def query
    <<~GQL
      query adherenceScore {
        adherenceScore(treatmentSchedule: 3) {
          adherenceScore
          expectedInjection
          actualInjection
          onTimeInjection
          injectionsGraph {
            date
            day
            month
            year
            weekDay
            expectedInjection
            hasInjection
          }
        }
      }
    GQL
  end
end

