source 'https://rubygems.org'

ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'rails-api'
gem "active_model_serializers"

gem 'devise'

# Use Twillio
gem 'twilio-ruby'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Env Variable management
gem 'figaro'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

group :test do
  gem "rspec-rails"
#  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'sqlite3'
  gem 'debugger'
end

group :development do
  gem "rspec-rails"
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'sqlite3'
  gem 'debugger'
end

# Heroku gems
group :production do
  gem 'rails_12factor'
  gem 'pg'
end