class Mutations::CreatePatient < Mutations::BaseMutation
  field :patient, Types::PatientType, null: false
  argument :full_name, String, required: true

  def resolve(full_name:)
    create_patient = Patients::Create.call(full_name:)
    create_patient.success? ? { patient: create_patient.patient } : execution_error(errors: create_patient.errors)
  end
end

