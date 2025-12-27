# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is required' do
    user = User.new(email: ' ')
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'email is normalized before validation' do
    user = User.new(email: '  TeSt@Example.COM ')
    assert user.valid?
    assert_equal 'test@example.com', user.email
  end

  test 'email must be unique after normalization' do
    User.create!(email: 'unique@example.com')
    user = User.new(email: 'Unique@Example.com')
    assert_not user.valid?
    assert_includes user.errors[:email], 'has already been taken'
  end
end
