class Injections::Index < BaseInteractor
  ERROR_MESSAGE = "injection.list_process_fails".freeze
  delegate :injections, to: :context

  before :set_injections, :with_patient

  def call; end

  def set_injections
    context.injections = Injection.all
  end

  def with_patient
    context.injections = injections.where(patient_id: context.patient_id) if context.patient_id.present?
  end
end

