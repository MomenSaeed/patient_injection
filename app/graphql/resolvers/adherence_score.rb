class Resolvers::AdherenceScore < Resolvers::BaseResolver
  type Types::Adherence::ScoreType, null: true
  argument :end_date, String, required: false
  argument :start_date, String, required: false
  argument :treatment_schedule, Int, required: true

  def resolve(treatment_schedule:, start_date: nil, end_date: nil)
    adherence_score = Adherence::Score.call(patient: current_patient, start_date:, end_date:, treatment_schedule:)
    adherence_score.success? ? adherence_score.result : execution_error(errors: create_injection.errors)
  end
end

