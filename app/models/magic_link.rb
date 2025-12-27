# frozen_string_literal: true

require 'digest'

class MagicLink < ApplicationRecord
  TOKEN_TTL = 15.minutes

  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true
  validates :expires_at, presence: true

  def self.issue_for(user)
    raw_token = SecureRandom.urlsafe_base64(32)
    create!(
      user: user,
      token_digest: digest(raw_token),
      expires_at: TOKEN_TTL.from_now
    )
    raw_token
  end

  def self.consume!(raw_token)
    return nil if raw_token.blank?

    magic_link = find_by(token_digest: digest(raw_token))
    return nil unless magic_link&.usable?

    magic_link.update!(used_at: Time.current)
    magic_link.user
  end

  def usable?
    used_at.nil? && expires_at > Time.current
  end

  def self.digest(raw_token)
    Digest::SHA256.hexdigest(raw_token)
  end
end
