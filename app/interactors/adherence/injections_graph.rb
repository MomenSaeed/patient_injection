class Adherence::InjectionsGraph < BaseInteractor
  ERROR_MESSAGE = "injection_graph.process_failed".freeze

  delegate :start_date, to: :context
  delegate :end_date, to: :context
  delegate :patient, to: :context
  delegate :treatment_schedule, to: :context

  delegate :injections, to: :context
  delegate :schedule, to: :context
  delegate :injections_graph, to: :context

  before :set_injections, :set_schedule

  def call
    context.injections_graph = (Date.parse(start_date)..Date.parse(end_date)).each_with_object([]) do |date, array|
      array.push({
                   date:,
                   has_injection:      injections.any? { |i| i.created_at.to_date == date },
                   expected_injection: schedule.occurs_at?(date),
                 })
    end
  end

  def set_injections
    context.injections = ::Injection.where(patient_id: patient.id)
  end

  def set_schedule
    context.schedule = IceCube::Schedule.new(patient.created_at.to_date) do |s|
      s.add_recurrence_rule(IceCube::Rule.daily(treatment_schedule))
    end
  end
end

