Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # 本番環境では適切に制限すること！
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
