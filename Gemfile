source 'https://rubygems.org'

gem 'rails', '4.0.4'
gem 'pg'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem "bcrypt-ruby"
gem "figaro"
gem 'httparty'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'twitter'
gem 'bootstrap_form'
gem 'newrelic_rpm'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem "rspec-rails"
  gem "guard-rspec"
  gem "terminal-notifier-guard"
  gem "factory_girl_rails"
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'capybara'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
end

gem 'therubyracer', platforms: :ruby

gem "codeclimate-test-reporter", group: :test, require: nil
gem 'simplecov', '~> 0.7.1', :require => false, :group => :test

group :production do
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
