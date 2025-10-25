# frozen_string_literal: true

allowed_origins =
  if Rails.env.production?
    # 例: CORS_ORIGINS="https://app.example.com,https://admin.example.com"
    ENV.fetch('CORS_ORIGINS').split(',').map(&:strip)
  else
    '*'
  end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins allowed_origins
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head]
    # , expose: %w[Authorization]     # Bearerトークンをレスポンスで見せたい場合
    # , credentials: true              # Cookieを使う場合はtrue（*は不可; 本番は明示ドメイン必須）
  end
end
