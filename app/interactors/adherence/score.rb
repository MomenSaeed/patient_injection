class Adherence::Score < BaseInteractor
  ERROR_MESSAGE = "adherence.process_failed".freeze

  delegate :patient, to: :context
  delegate :start_date, to: :context
  delegate :end_date, to: :context
  delegate :treatment_schedule, to: :context
  delegate :injections_graph, to: :context

  before :set_patient, :set_injections_graph

  def call
    context.result = {
      injections_graph:,
      expected_injection:,
      actual_injection:,
      on_time_injection:,
      adherence_score:,
    }
  end

  def set_patient
    context.patient = ::Patient.find(context.patient_id)
  end

  def set_injections_graph
    context.injections_graph = Adherence::InjectionsGraph.call(
      patient:, start_date:, end_date:, treatment_schedule:
    ).injections_graph
  end

  def expected_injection
    injections_graph.count { |injection| injection[:expected_injection] }
  end

  def actual_injection
    injections_graph.count { |injection| injection[:has_injection] }
  end

  def on_time_injection
    injections_graph.count { |injection| injection[:expected_injection] && injection[:has_injection] }
  end

  def adherence_score
    return 0 if on_time_injection.zero?

    ((on_time_injection * 100.00) / expected_injection).ceil
  end
end

