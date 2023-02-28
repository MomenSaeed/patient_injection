# frozen_string_literal: true

class Types::PatientType < Types::BaseObject
  description "Patient Type"

  field :api_key, String, null: false, description: "apiKey field => used for Authentication"
  field :full_name, String, null: false, description: "full_name field"
  field :id, ID, null: false, description: "id field"
end

