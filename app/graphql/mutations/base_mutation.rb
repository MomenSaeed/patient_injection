class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  argument_class Types::BaseArgument
  field_class Types::BaseField
  input_object_class Types::BaseInputObject
  object_class Types::BaseObject

  UNAUTHORIZED_FIELDS = %w[createPatient].freeze

  def authorized?(*_args)
    super()
    UNAUTHORIZED_FIELDS.include?(field.name) || logged_in?
  end

  include PatientContext
end

