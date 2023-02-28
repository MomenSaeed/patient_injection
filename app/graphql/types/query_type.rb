class Types::QueryType < Types::BaseObject
  description "Listing all graphql query types"

  # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
  include GraphQL::Types::Relay::HasNodeField
  include GraphQL::Types::Relay::HasNodesField

  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :patients, [Types::PatientType], null: false

  def patients
    Patient.all
  end
end

