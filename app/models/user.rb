# frozen_string_literal: true

class User < ApplicationRecord
  has_many :magic_links, dependent: :destroy

  before_validation :normalize_email

  validates :email, presence: true, uniqueness: true

  private

  def normalize_email
    self.email = email.to_s.strip.downcase.presence
  end
end
