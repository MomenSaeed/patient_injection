FactoryBot.define do
  factory :patient do
    full_name { Faker::Internet.full_name }
    api_key { SecureRandom.hex }
  end
end

