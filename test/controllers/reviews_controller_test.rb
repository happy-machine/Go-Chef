require 'test_helper'
require 'minitest/autorun'


class ReviewsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get '/users', params:{id:users(:one).id.to_s}
    assert_response :success
  end

  test "should get show" do
    get reviews_show_url
    assert_response :success
    assert_match users(:one).id, @response.body
  end
=begin
  test "should get new" do
    get reviews_new_url
    assert_response :success
  end

  test "should get edit" do
    get reviews_edit_url
    assert_response :success
  end

  test "should get delete" do
    get reviews_delete_url
    assert_response :success
  end
=end

end
