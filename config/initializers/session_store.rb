# frozen_string_literal: true

require 'uri'

cors_origins = ENV['FRONTEND_URL'].to_s.split(',').map(&:strip).reject(&:empty?)

cookie_domain =
  if ENV['SESSION_DOMAIN'].present?
    ENV['SESSION_DOMAIN']
  else
    hosts = cors_origins.filter_map do |origin|
      URI.parse(origin).host
    rescue URI::InvalidURIError
      nil
    end.uniq

    if hosts.size > 1
      Rails.logger.warn('[session_store] Multiple FRONTEND_URL hosts detected; set SESSION_DOMAIN to share cookies.')
    end

    hosts.first if hosts.size == 1
  end

Rails.application.config.session_store :cookie_store,
                                       key: '_app_session',
                                       same_site: (ENV['SESSION_SAME_SITE'] || 'Lax').to_sym, # 'None' or 'Lax'
                                       secure: true,
                                       domain: cookie_domain
