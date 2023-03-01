# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FactoryBot.create(:patient, api_key: "15436c2791108e5c16dcdfc1f99aa732") unless Patient.find_by_api_key("15436c2791108e5c16dcdfc1f99aa732")
FactoryBot.create_list(:patient, 10)

Patient.all.each do |patient|
  FactoryBot.create_list(:injection, 10, patient:)
end

