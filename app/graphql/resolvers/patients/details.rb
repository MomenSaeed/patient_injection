class Resolvers::Patients::Details < Resolvers::BaseResolver
  type Types::PatientType, null: true

  def resolve
    ::Patients::Details.call(patient_id: current_patient&.id).patient
  end
end

