class Resolvers::Injections::Index < Resolvers::BaseResolver
  type Types::Injection::Type.connection_type, null: true

  argument :patient_id, ID, required: true

  def resolve(patient_id:)
    ::Injections::Index.call(patient_id:).injections
  end
end

