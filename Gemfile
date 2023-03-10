source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# A plain-Ruby implementation of GraphQL.
gem "graphql", "~> 2.0", ">= 2.0.17"

# Interactor provides a common interface for performing complex user interactions.
gem "interactor", "~> 3.1", ">= 3.1.2"

# a recurring date library for Ruby. It allows for quick, programatic expansion of recurring date rules.
gem "ice_cube", "~> 0.14.0"

# Middleware that will make Rack-based apps CORS compatible.
gem "rack-cors", "~> 2.0"

gem "faker"
gem "factory_bot_rails", "~> 6.2"

# Prometheus metric collector and exporter for Ruby
gem "prometheus_exporter", "~> 2.0", ">= 2.0.8"

group :development, :test do
  gem "pry"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1", require: false
  gem "database_cleaner", require: false
  gem "shoulda-matchers", "~> 5.3", require: false
  gem "shoulda-context", "~> 2.0", require: false
  gem "rubocop", require: false
  gem "rubocop-graphql", require: false
  gem "rubocop-rspec", require: false
  gem "simplecov", "~> 0.21.0", require: false
end
group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

