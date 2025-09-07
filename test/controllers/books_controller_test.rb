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
           params: { book: { title: 'New Book', author: 'New Author', published_date: '2023-01-01' } }
    end

    assert_response :created
    body = JSON.parse(@response.body)
    assert_equal 'New Book', body['title']
    assert_equal 'New Author', body['author']
    assert_equal '2023-01-01', body['published_date']
  end

  test 'create fails without title' do
    assert_no_difference('Book.count') do
      post books_url, params: { book: { author: 'X' } }, as: :json
    end
    assert_response :unprocessable_entity
    errors = response.parsed_body
    assert_includes errors.to_s, 'title'
  end

  test 'updates title' do
    book = books(:one)

    patch book_url(book.id), params: { book: { title: 'Updated Title' } }
    assert_response :ok

    assert_equal 'Updated Title', book.reload.title
  end
end
