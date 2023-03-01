require "rails_helper"

RSpec.describe Adherence::InjectionsGraph do
  subject(:graph_context) do
    injections
    described_class.call(
      patient:, treatment_schedule:, start_date:, end_date:
    )
  end

  let!(:patient) { create(:patient, created_at: DateTime.now - 30.days) }
  let(:injections) { create_list(:injection, 10, patient:) }

  let!(:treatment_schedule) { 3 }

  let(:schedule) do
    IceCube::Schedule.new(patient.created_at.to_date) do |s|
      s.add_recurrence_rule(IceCube::Rule.daily(treatment_schedule))
    end
  end

  let(:start_date) { patient.created_at.to_date.to_s }
  let(:end_date) { Date.today.to_s }

  it "succeeds" do
    expect(graph_context).to be_a_success
  end

  it "returns all injections graph" do
    expect(graph_context.injections_graph).to eq(
      (Date.parse(start_date)..Date.parse(end_date)
      ).each_with_object([]) do |date, array|
        array.push({
                     date:,
                     has_injection:      injections.any? { |i| i.created_at.to_date == date },
                     expected_injection: schedule.occurs_at?(date),
                   })
      end
    )
  end
end

