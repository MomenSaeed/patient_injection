class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  argument_class Types::BaseArgument
  field_class Types::BaseField
  input_object_class Types::BaseInputObject
  object_class Types::BaseObject

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

