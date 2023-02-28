# frozen_string_literal: true

class Types::Injection::Type < Types::BaseObject
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :dose, Float, null: false
  field :drug_name, String, null: false
  field :id, ID, null: false
  field :lot_number, String, null: false
  field :patient, Types::PatientType, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end

