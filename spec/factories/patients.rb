FactoryBot.define do
  factory :patient do
    full_name { Faker::Name.name }
    api_key { SecureRandom.hex }
    created_at { DateTime.now - 30.days }
  end
end

