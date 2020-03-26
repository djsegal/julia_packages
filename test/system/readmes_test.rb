require "application_system_test_case"

class ReadmesTest < ApplicationSystemTestCase
  setup do
    @readme = readmes(:one)
  end

  test "visiting the index" do
    visit readmes_url
    assert_selector "h1", text: "Readmes"
  end

  test "creating a Readme" do
    visit readmes_url
    click_on "New Readme"

    fill_in "Html", with: @readme.html
    fill_in "Package", with: @readme.package_id
    fill_in "Search", with: @readme.search
    click_on "Create Readme"

    assert_text "Readme was successfully created"
    click_on "Back"
  end

  test "updating a Readme" do
    visit readmes_url
    click_on "Edit", match: :first

    fill_in "Html", with: @readme.html
    fill_in "Package", with: @readme.package_id
    fill_in "Search", with: @readme.search
    click_on "Update Readme"

    assert_text "Readme was successfully updated"
    click_on "Back"
  end

  test "destroying a Readme" do
    visit readmes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Readme was successfully destroyed"
  end
end
