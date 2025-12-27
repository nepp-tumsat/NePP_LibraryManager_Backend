# frozen_string_literal: true

require 'test_helper'

class MagicLinkTest < ActiveSupport::TestCase
  include ActiveSupport::Testing::TimeHelpers

  test 'issue_for creates a usable magic link' do
    user = User.create!(email: 'issue@example.com')
    raw_token = MagicLink.issue_for(user)

    assert raw_token.present?

    magic_link = MagicLink.find_by(token_digest: MagicLink.digest(raw_token))
    assert magic_link.present?
    assert_nil magic_link.used_at
    assert magic_link.expires_at > Time.current
  end

  test 'consume returns user and marks token used' do
    user = User.create!(email: 'consume@example.com')
    raw_token = MagicLink.issue_for(user)

    assert_equal user, MagicLink.consume!(raw_token)

    magic_link = MagicLink.find_by(token_digest: MagicLink.digest(raw_token))
    assert magic_link.used_at.present?
  end

  test 'consume returns nil for blank token' do
    assert_nil MagicLink.consume!('')
  end

  test 'consume returns nil for expired token' do
    user = User.create!(email: 'expired@example.com')
    raw_token = MagicLink.issue_for(user)

    travel_to 20.minutes.from_now do
      assert_nil MagicLink.consume!(raw_token)
    end
  end

  test 'consume returns nil when token already used' do
    user = User.create!(email: 'used@example.com')
    raw_token = MagicLink.issue_for(user)

    MagicLink.consume!(raw_token)

    assert_nil MagicLink.consume!(raw_token)
  end
end
