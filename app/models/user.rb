# frozen_string_literal: true

require 'uri'

class User < ApplicationRecord
  has_many :magic_links, dependent: :destroy

  before_validation :normalize_email

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.normalize_email(value)
    value.to_s.strip.downcase.presence
  end

  private

  def normalize_email
    self.email = self.class.normalize_email(email)
  end
end
