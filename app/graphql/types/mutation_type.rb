class Types::MutationType < Types::BaseObject
  description "Listing all graphql mutation types"

  field :createPatient, mutation: Mutations::CreatePatient
end

