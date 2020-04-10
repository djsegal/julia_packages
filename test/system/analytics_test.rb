require "application_system_test_case"

class AnalyticsTest < ApplicationSystemTestCase
  setup do
    @analytic = analytics(:one)
  end

  test "visiting the index" do
    visit analytics_url
    assert_selector "h1", text: "Analytics"
  end

  test "creating a Analytic" do
    visit analytics_url
    click_on "New Analytic"

    click_on "Create Analytic"

    assert_text "Analytic was successfully created"
    click_on "Back"
  end

  test "updating a Analytic" do
    visit analytics_url
    click_on "Edit", match: :first

    click_on "Update Analytic"

    assert_text "Analytic was successfully updated"
    click_on "Back"
  end

  test "destroying a Analytic" do
    visit analytics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Analytic was successfully destroyed"
  end
end
