require "application_system_test_case"

class DependenciesTest < ApplicationSystemTestCase
  setup do
    @dependency = dependencies(:one)
  end

  test "visiting the index" do
    visit dependencies_url
    assert_selector "h1", text: "Dependencies"
  end

  test "creating a Dependency" do
    visit dependencies_url
    click_on "New Dependency"

    fill_in "Dependee", with: @dependency.dependee_id
    fill_in "Depender", with: @dependency.depender_id
    check "Shallow" if @dependency.shallow
    click_on "Create Dependency"

    assert_text "Dependency was successfully created"
    click_on "Back"
  end

  test "updating a Dependency" do
    visit dependencies_url
    click_on "Edit", match: :first

    fill_in "Dependee", with: @dependency.dependee_id
    fill_in "Depender", with: @dependency.depender_id
    check "Shallow" if @dependency.shallow
    click_on "Update Dependency"

    assert_text "Dependency was successfully updated"
    click_on "Back"
  end

  test "destroying a Dependency" do
    visit dependencies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dependency was successfully destroyed"
  end
end
