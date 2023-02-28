class Resolvers::BaseResolver < GraphQL::Schema::Resolver
  argument_class Types::BaseArgument

  def execution_error(message: nil, errors: nil, status: :unprocessable_entity, code: 422)
    GraphQL::ExecutionError.new(
      message,
      options: {
        status:,
        code:,
        errors:,
      }
    )
  end
end

