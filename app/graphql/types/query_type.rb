class Types::QueryType < Types::BaseObject
  description "Listing all graphql query types"

  include GraphQL::Types::Relay::HasNodeField
  include GraphQL::Types::Relay::HasNodesField

  field :patient, resolver: Resolvers::Patients::Details
  field :patients_connection, resolver: Resolvers::Patients::Index

  field :injection, resolver: Resolvers::Injections::Details
  field :injections_connection, resolver: Resolvers::Injections::Index

  field :adherence_score, resolver: Resolvers::AdherenceScore
end

