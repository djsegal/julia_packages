require 'test_helper'

class ReadmesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @readme = readmes(:one)
  end

  test "should get index" do
    get readmes_url
    assert_response :success
  end

  test "should get new" do
    get new_readme_url
    assert_response :success
  end

  test "should create readme" do
    assert_difference('Readme.count') do
      post readmes_url, params: { readme: { html: @readme.html, package_id: @readme.package_id, search: @readme.search } }
    end

    assert_redirected_to readme_url(Readme.last)
  end

  test "should show readme" do
    get readme_url(@readme)
    assert_response :success
  end

  test "should get edit" do
    get edit_readme_url(@readme)
    assert_response :success
  end

  test "should update readme" do
    patch readme_url(@readme), params: { readme: { html: @readme.html, package_id: @readme.package_id, search: @readme.search } }
    assert_redirected_to readme_url(@readme)
  end

  test "should destroy readme" do
    assert_difference('Readme.count', -1) do
      delete readme_url(@readme)
    end

    assert_redirected_to readmes_url
  end
end
