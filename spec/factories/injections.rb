FactoryBot.define do
  factory :injection do
    dose { 1.5 }
    lot_number { Faker::Alphanumeric.alpha(number: 6) }
    drug_name { %w[Kratom MDMA PCP].sample }
    sequence :created_at do
      Faker::Time.between(from: DateTime.now - 30.days, to: DateTime.now)
    end
  end
end

