# frozen_string_literal: true

class MagicLinkMailer < ApplicationMailer
  def login_link(user:, token:)
    base_url = ENV.fetch('MAGIC_LINK_URL_BASE', 'http://localhost:3000').delete_suffix('/')
    @login_url = "#{base_url}/magic_links/#{token}"

    mail to: user.email, subject: I18n.t('mailers.magic_link.subject')
  end
end
