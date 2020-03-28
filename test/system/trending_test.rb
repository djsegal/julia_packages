require "application_system_test_case"

class TrendingTest < ApplicationSystemTestCase
  setup do
    @trending = trendings(:one)
  end

  test "visiting the index" do
    visit trendings_url
    assert_selector "h1", text: "Trendings"
  end

  test "creating a Trending" do
    visit trendings_url
    click_on "New Trending"

    click_on "Create Trending"

    assert_text "Trending was successfully created"
    click_on "Back"
  end

  test "updating a Trending" do
    visit trendings_url
    click_on "Edit", match: :first

    click_on "Update Trending"

    assert_text "Trending was successfully updated"
    click_on "Back"
  end

  test "destroying a Trending" do
    visit trendings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trending was successfully destroyed"
  end
end
