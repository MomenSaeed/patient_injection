class Patients::Details < BaseInteractor
  ERROR_MESSAGE = "patient.not_exists".freeze

  delegate :patient, to: :context

  def call
    context.patient = Patient.find_by_id(context.patient_id)
  end
end

