class Resolvers::Injections::Index < Resolvers::BaseResolver
  type Types::Injection::Type.connection_type, null: true

  def resolve
    ::Injections::Index.call(patient_id: current_patient&.id).injections.order(created_at: :desc)
  end
end

