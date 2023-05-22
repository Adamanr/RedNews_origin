require "application_system_test_case"

class EditionsTest < ApplicationSystemTestCase
  setup do
    @edition = editions(:one)
  end

  test "visiting the index" do
    visit editions_url
    assert_selector "h1", text: "Editions"
  end

  test "should create edition" do
    visit editions_url
    click_on "New edition"

    fill_in "Category", with: @edition.category
    fill_in "Desc", with: @edition.desc
    fill_in "Name", with: @edition.name
    fill_in "Rating", with: @edition.rating
    fill_in "Url", with: @edition.url
    fill_in "User", with: @edition.user_id
    check "Verified" if @edition.verified
    click_on "Create Edition"

    assert_text "Edition was successfully created"
    click_on "Back"
  end

  test "should update Edition" do
    visit edition_url(@edition)
    click_on "Edit this edition", match: :first

    fill_in "Category", with: @edition.category
    fill_in "Desc", with: @edition.desc
    fill_in "Name", with: @edition.name
    fill_in "Rating", with: @edition.rating
    fill_in "Url", with: @edition.url
    fill_in "User", with: @edition.user_id
    check "Verified" if @edition.verified
    click_on "Update Edition"

    assert_text "Edition was successfully updated"
    click_on "Back"
  end

  test "should destroy Edition" do
    visit edition_url(@edition)
    click_on "Destroy this edition", match: :first

    assert_text "Edition was successfully destroyed"
  end
end
