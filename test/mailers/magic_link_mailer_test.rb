# frozen_string_literal: true

require 'test_helper'

class MagicLinkMailerTest < ActionMailer::TestCase
  test 'login_link' do
    user = users(:one)
    mail = MagicLinkMailer.login_link(user: user, token: 'test-token')
    assert_equal I18n.t('mailers.magic_link.subject'), mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_includes mail.body.encoded, 'test-token'
  end
end
