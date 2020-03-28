require 'test_helper'

class TrendingControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trending = trendings(:one)
  end

  test "should get index" do
    get trendings_url
    assert_response :success
  end

  test "should get new" do
    get new_trending_url
    assert_response :success
  end

  test "should create trending" do
    assert_difference('Trending.count') do
      post trendings_url, params: { trending: {  } }
    end

    assert_redirected_to trending_url(Trending.last)
  end

  test "should show trending" do
    get trending_url(@trending)
    assert_response :success
  end

  test "should get edit" do
    get edit_trending_url(@trending)
    assert_response :success
  end

  test "should update trending" do
    patch trending_url(@trending), params: { trending: {  } }
    assert_redirected_to trending_url(@trending)
  end

  test "should destroy trending" do
    assert_difference('Trending.count', -1) do
      delete trending_url(@trending)
    end

    assert_redirected_to trendings_url
  end
end
