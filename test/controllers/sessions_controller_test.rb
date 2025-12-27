# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'returns unauthorized when not logged in' do
    https!
    get session_url
    assert_response :unauthorized
    assert_equal({ 'user' => nil }, response.parsed_body)
  end

  test 'returns current user when logged in' do
    user = User.create!(email: 'session@example.com')
    raw_token = MagicLink.issue_for(user)

    https!
    get magic_link_url(raw_token)
    assert_redirected_to 'http://frontend.test'

    get session_url
    assert_response :success
    assert_equal user.id, response.parsed_body['id']
  end

  test 'destroy clears session' do
    user = User.create!(email: 'logout@example.com')
    raw_token = MagicLink.issue_for(user)

    https!
    get magic_link_url(raw_token)
    assert_redirected_to 'http://frontend.test'

    delete session_url
    assert_response :no_content

    get session_url
    assert_response :unauthorized
  end
end
