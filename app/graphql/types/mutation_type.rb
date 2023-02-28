class Types::MutationType < Types::BaseObject
  description "Listing all graphql mutation types"

  # TODO: remove me
  field :test_field, String, null:        false,
                             description: "An example field added by the generator"
  def test_field
    "Hello World"
  end
end

