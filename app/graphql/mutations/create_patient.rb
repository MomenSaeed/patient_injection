class Mutations::CreatePatient < Mutations::BaseMutation
  field :patient, Types::PatientType, null: true
  argument :full_name, String, required: true

  def resolve(full_name:)
    patient = ::Patient.new(full_name:, api_key: SecureRandom.hex)
    patient.save ? { patient: } : execution_error(message: patient.errors.full_messages, errors: patient.errors)
  end
end

