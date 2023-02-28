class Resolvers::Patients::Details < Resolvers::BaseResolver
  type Types::PatientType, null: true
  argument :id, ID, required: true

  def resolve(id:)
    ::Patients::Details.call(patient_id: id).patient
  end
end

