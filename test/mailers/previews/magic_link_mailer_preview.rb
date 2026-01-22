# frozen_string_literal: true

# Preview all emails at http://localhost:3001/rails/mailers/magic_link_mailer
class MagicLinkMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3001/rails/mailers/magic_link_mailer/login_link
  def login_link
    user = User.first || User.new(email: 'preview@example.com')
    MagicLinkMailer.login_link(user: user, token: 'preview-token')
  end
end
