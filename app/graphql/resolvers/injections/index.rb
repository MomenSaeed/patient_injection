class Resolvers::Injections::Index < Resolvers::BaseResolver
  type Types::Injection::Type.connection_type, null: true

  def resolve
    ::Injections::Index.call.injections
  end
end

