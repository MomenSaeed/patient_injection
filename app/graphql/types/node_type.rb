module Types::NodeType
  description "Node Type as parent for single models type"

  include Types::BaseInterface
  # Add the `id` field
  include GraphQL::Types::Relay::NodeBehaviors
end

