# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.7'
gem 'rails', '~> 7.2', '>= 7.2.2.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'rack-cors'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rubocop', '>= 1.75', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'erb_lint'
  gem 'hotwire-livereload', '~> 1.2'
  gem 'ruby-lsp'
  gem 'ruby-lsp-rails'
  gem 'solargraph'
  gem 'syntax_tree'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver', '>= 4.11'
end

gem 'fiddle'
gem 'nokogiri', '>= 1.18.9'
gem 'ostruct'
gem 'rack-session', '>= 2.1.1'
gem 'thor', '>= 1.4.0'
# Security floor pins
gem 'net-imap', '>= 0.4.20'
