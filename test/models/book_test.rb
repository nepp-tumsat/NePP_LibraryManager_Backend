# frozen_string_literal: true

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test 'title is required' do
    book = Book.new(author: 'X')
    assert_not book.valid?
    assert_includes book.errors[:title], "can't be blank"
  end

  test 'title cannot be whitespace only' do
    book = Book.new(title: '   ')
    assert_not book.valid?
    assert_includes book.errors[:title], "can't be blank"
  end
end
