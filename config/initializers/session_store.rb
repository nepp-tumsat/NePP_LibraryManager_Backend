# frozen_string_literal: true

require 'uri'

cors_origins = ENV['FRONTEND_URL'].to_s.split(',').map(&:strip).reject(&:empty?)
raise 'FRONTEND_URL is required in production' if Rails.env.production? && cors_origins.empty?

cookie_domain =
  if ENV['SESSION_DOMAIN'].present?
    ENV['SESSION_DOMAIN']
  else
    hosts = cors_origins.filter_map do |origin|
      URI.parse(origin).host
    rescue URI::InvalidURIError
      Rails.logger.warn("[session_store] Invalid FRONTEND_URL origin: #{origin}")
      nil
    end.uniq

    if hosts.size > 1
      Rails.logger.warn('[session_store] Multiple FRONTEND_URL hosts detected; set SESSION_DOMAIN to share cookies.')
    end

    hosts.first if hosts.size == 1
  end

same_site = (ENV['SESSION_SAME_SITE'] || 'Lax').to_sym
if same_site == :None && !Rails.env.production?
  Rails.logger.warn('[session_store] SESSION_SAME_SITE=None requires HTTPS; authentication may fail without HTTPS.')
end

Rails.application.config.session_store :cookie_store,
                                       key: '_app_session',
                                       same_site: same_site, # 'None' or 'Lax'
                                       secure: true,
                                       domain: cookie_domain
