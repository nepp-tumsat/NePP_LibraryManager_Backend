# frozen_string_literal: true

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should get index' do
    get books_url
    assert_response :success
    parsed_body = JSON.parse(@response.body)
    assert_equal 2, parsed_body.size
  end

  test 'should show book' do
    get book_url(books(:one))
    assert_response :success
    parsed_body = JSON.parse(@response.body)
    assert_equal books(:one).title, parsed_body['title']
  end

  test 'should create book' do
    assert_difference('Book.count') do
      post books_url,
           params: { book: { title: 'New Book', author: 'New Author', published_date: '2023-01-01',
                             isbn: '1234567890' } }
    end
    assert_response :created
  end
  test 'should update book' do
    patch book_url(books(:one)), params: { book: { title: 'Updated Title' } }
    assert_response :success
    books(:one).reload
    assert_equal 'Updated Title', books(:one).title
  end
end
