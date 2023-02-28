class Types::MutationType < Types::BaseObject
  description "Listing all graphql mutation types"

  field :createInjection, mutation: Mutations::CreateInjection
  field :createPatient, mutation: Mutations::CreatePatient
end

