# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodespacesTryRails
  class Application < Rails::Application
    config.load_defaults 7.2
    config.api_only = true

    # Enable cookies and sessions in API-only mode for magic-link login.
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
  end
end
