class Types::MutationType < Types::BaseObject
  description "The mutation root of this schema"

  field :createInjection, mutation: Mutations::CreateInjection
  field :createPatient, mutation: Mutations::CreatePatient
end

