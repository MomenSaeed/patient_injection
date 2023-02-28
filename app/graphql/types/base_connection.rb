class Types::BaseConnection < Types::BaseObject
  # add `nodes` and `pageInfo` fields, as well as `edge_type(...)` and `node_nullable(...)` overrides
  include GraphQL::Types::Relay::ConnectionBehaviors

  field :count, Integer, null: false
  field :total_count, Integer, null: false

  def count
    object.nodes&.count
  end

  def total_count
    object.items&.count
  end
end

