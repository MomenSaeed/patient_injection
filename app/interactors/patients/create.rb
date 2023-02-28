class Patients::Create < BaseInteractor
  ERROR_MESSAGE = "patient.create_failed".freeze

  delegate :patient, to: :context

  before :set_patient, :validate_patient

  def call
    patient.save
  end

  private

    def set_patient
      context.patient = Patient.new(full_name: context.full_name).tap do |a|
        a.api_key = SecureRandom.hex
      end
    end

    def validate_patient
      context.errors = []
      return if patient.valid?

      group_errors(patient)
    end
end

