class Resolvers::BaseResolver < GraphQL::Schema::Resolver
  argument_class Types::BaseArgument

  def authorized?(*_args)
    super()
    logged_in?
  end

  include PatientContext
end

