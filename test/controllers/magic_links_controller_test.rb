# frozen_string_literal: true

require 'test_helper'

class MagicLinksControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'creates magic link and sends email' do
    ActionMailer::Base.deliveries.clear

    perform_enqueued_jobs do
      assert_difference(['User.count', 'MagicLink.count', 'ActionMailer::Base.deliveries.size']) do
        post magic_links_url, params: { email: 'new-user@example.com' }, as: :json
      end
    end

    assert_response :accepted
    assert_equal ['new-user@example.com'], ActionMailer::Base.deliveries.last.to
  end

  test 'create returns error when email missing' do
    assert_no_difference(['User.count', 'MagicLink.count']) do
      post magic_links_url, params: {}, as: :json
    end

    assert_response :unprocessable_entity
    assert_equal 'email_required', response.parsed_body['error']
  end

  test 'create returns error when email is invalid' do
    assert_no_difference(['User.count', 'MagicLink.count']) do
      post magic_links_url, params: { email: 'not-an-email' }, as: :json
    end

    assert_response :unprocessable_entity
    assert_equal 'invalid_email', response.parsed_body['error']
  end

  test 'show consumes token and redirects to frontend' do
    user = User.create!(email: 'magic@example.com')
    raw_token = MagicLink.issue_for(user)

    https!
    get magic_link_url(raw_token)
    assert_redirected_to 'http://frontend.test'

    get session_url
    assert_response :success
    assert_equal user.id, response.parsed_body['id']
  end

  test 'show redirects to failure when token invalid' do
    https!
    get magic_link_url('invalid-token')
    assert_redirected_to 'http://frontend.test/failure'
  end
end
