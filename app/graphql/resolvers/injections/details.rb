class Resolvers::Injections::Details < Resolvers::BaseResolver
  type Types::Injection::Type, null: true
  argument :id, ID, required: true

  def resolve(id:)
    ::Injections::Details.call(injection_id: id).injection
  end
end

