class Resolvers::Patients::Index < Resolvers::BaseResolver
  type Types::PatientType.connection_type, null: true

  def resolve
    ::Patients::Index.call.patients
  end
end

