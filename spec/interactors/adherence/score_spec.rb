require "rails_helper"

RSpec.describe Adherence::Score do
  let!(:patient) { create(:patient, created_at: DateTime.now - 30.days) }
  let(:injections) { create_list(:injection, 10, patient:) }

  let!(:treatment_schedule) { 3 }

  context "without date filters" do
    subject(:score_context) do
      injections
      described_class.call(patient_id: patient.id, treatment_schedule:)
    end

    it "succeeds" do
      expect(score_context).to be_a_success
    end

    it "returns all injections graph" do
      score = score_context
      expect(score[:injections_graph].size).to eq(31)
    end

    it "returns adherence expected injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:expected_injection]).to eq(injections_graph.count { |injection| injection[:expected_injection] })
    end

    it "returns adherence actual injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:actual_injection]).to eq(injections_graph.count { |injection| injection[:has_injection] })
    end

    it "returns adherence on time injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:on_time_injection]).to eq(injections_graph.count { |injection| injection[:expected_injection] && injection[:has_injection] })
    end
  end

  context "with date filters" do
    subject(:score_context) do
      injections
      described_class.call(
        patient_id: patient.id, treatment_schedule:,
        start_date: (Date.today - 7.days).to_s,
        end_date: (Date.today - 2.days).to_s
      )
    end

    it "succeeds" do
      expect(score_context).to be_a_success
    end

    it "returns all injections graph" do
      score = score_context
      expect(score[:injections_graph].size).to eq(6)
    end

    it "returns adherence expected injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:expected_injection]).to eq(injections_graph.count { |injection| injection[:expected_injection] })
    end

    it "returns adherence actual injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:actual_injection]).to eq(injections_graph.count { |injection| injection[:has_injection] })
    end

    it "returns adherence on time injection" do
      score = score_context.result
      injections_graph = score[:injections_graph]
      expect(score[:on_time_injection]).to eq(injections_graph.count { |injection| injection[:expected_injection] && injection[:has_injection] })
    end
  end
end

