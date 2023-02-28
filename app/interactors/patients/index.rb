class Patients::Index < BaseInteractor
  ERROR_MESSAGE = "patient.list_process_fails".freeze
  delegate :patients, to: :context

  def call
    context.patients = Patient.all
  end
end

