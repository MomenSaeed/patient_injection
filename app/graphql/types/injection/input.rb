# frozen_string_literal: true

class Types::Injection::Input < Types::BaseInputObject
  argument :dose, String, required: true
  argument :drug_name, String, required: true
  argument :lot_number, String, required: true
end

