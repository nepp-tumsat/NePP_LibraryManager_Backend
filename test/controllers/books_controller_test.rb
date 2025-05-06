require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get books_url
    assert_response :success
    parsed_body = JSON.parse(@response.body)
    assert_equal 2, parsed_body.size
  end
end
