require "application_system_test_case"

class UpdatesTest < ApplicationSystemTestCase
  setup do
    @update = updates(:one)
  end

  test "visiting the index" do
    visit updates_url
    assert_selector "h1", text: "Updates"
  end

  test "should create update" do
    visit updates_url
    click_on "New update"

    fill_in "Body", with: @update.body
    fill_in "Title", with: @update.title
    fill_in "User", with: @update.user_id
    click_on "Create Update"

    assert_text "Update was successfully created"
    click_on "Back"
  end

  test "should update Update" do
    visit update_url(@update)
    click_on "Edit this update", match: :first

    fill_in "Body", with: @update.body
    fill_in "Title", with: @update.title
    fill_in "User", with: @update.user_id
    click_on "Update Update"

    assert_text "Update was successfully updated"
    click_on "Back"
  end

  test "should destroy Update" do
    visit update_url(@update)
    click_on "Destroy this update", match: :first

    assert_text "Update was successfully destroyed"
  end
end
