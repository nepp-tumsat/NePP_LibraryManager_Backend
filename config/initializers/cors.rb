# frozen_string_literal: true

cors_origins = ENV['FRONTEND_URL'].to_s.split(',').map(&:strip).reject(&:empty?)

allowed_origins =
  if Rails.env.production?
    # 例: FRONTEND_URL="https://app.example.com,https://admin.example.com"
    raise 'FRONTEND_URL is required in production' if cors_origins.empty?

    cors_origins
  else
    cors_origins.any? ? cors_origins : ['http://localhost:5173']
  end

allow_credentials = allowed_origins != ['*']

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins allowed_origins
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: allow_credentials
  end
end
