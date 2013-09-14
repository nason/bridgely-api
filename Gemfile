source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'rails-api'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use Twillio
gem 'twilio-ruby'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# Use debugger
gem 'debugger', group: [:development, :test]

gem "rspec-rails", :group => [:test, :development]
group :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
end

group :development do
  gem 'guard-rails'
  gem 'guard-bundler'
end
