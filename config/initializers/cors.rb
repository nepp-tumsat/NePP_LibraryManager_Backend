# frozen_string_literal: true

cors_origins = ENV['FRONTEND_URL'].to_s.split(',').map(&:strip).reject(&:empty?)

allowed_origins =
  if Rails.env.production?
    # 例: CORS_ORIGINS="https://app.example.com,https://admin.example.com"
    raise 'CORS_ORIGINS is required in production' if cors_origins.empty?

    cors_origins
  else
    'http://localhost:5173'
  end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins allowed_origins
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: allowed_origins != '*'
  end
end
