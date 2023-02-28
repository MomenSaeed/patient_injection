require "project_adapter"

class Resolvers::BaseResolver < GraphQL::Schema::Resolver
  argument_class Types::BaseArgument
end

