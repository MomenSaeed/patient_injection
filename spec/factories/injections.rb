FactoryBot.define do
  factory :injection do
    dose { 1.5 }
    lot_number { "MyString" }
    drug_name { "MyString" }
    patient { nil }
  end
end

