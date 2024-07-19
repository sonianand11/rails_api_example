source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap','~> 1.18.3', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem 'image_processing', '~> 1.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors', '~> 2.0.2'

group :development, :test  do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem 'spring'
  gem 'pry', '~> 0.14.2'
  gem 'pry-rails', '~> 0.3.11'
  gem 'pry-byebug', '~> 3.10.1'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'brakeman', '~> 6.1.2'
  gem 'rubocop', '~> 1.65.0', require: false
  # gem 'rubocop-capybara', '~> 2.21.0'
  # gem 'rubocop-factory_bot', '~> 2.26.1'
  gem 'rubocop-rails', '~> 2.25.1', require: false
  # gem 'rubocop-rspec', '~> 3.0.3'
  # gem 'rubocop-rspec_rails', '~> 2.30.0'
end

group :test do
  gem 'rspec-rails', '~> 6.1.3'
  gem 'factory_bot_rails', '~> 6.4.3'
  gem 'capybara', '~> 3.40.0'
  gem 'database_cleaner', '~> 2.0.2'
  gem 'faker', '~> 3.4.1'
  gem 'shoulda-matchers', '~> 6.2.0'
  # gem 'route_mechanic', github: 'ohbarye/route_mechanic'
end


# Use Json Web Token (JWT) for token based authentication
gem 'jwt', '~> 2.8.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.20'

# Shim to load environment variables from .env into ENV in development.
gem 'dotenv', '~> 3.1.2'

# A fast JSON parser and Object marshaller as a Ruby gem.
gem 'oj', '~> 3.16.4'
# JSON Serializer for response
gem 'panko_serializer', '~> 0.8.2'

# for image processing. Used by ActiveStorage
gem 'image_processing', '~> 1.12.2'

# Fix security issue: URL: https://github.com/rack/rack/security/advisories/GHSA-cj83-2ww7-mvq7
gem 'rack', '~> 3.1.7'