FactoryBot.define do
  factory :patient do
    full_name { Faker::Name.name }
    api_key { SecureRandom.hex }
  end
end

