require "test_helper"

class EditionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edition = editions(:one)
  end

  test "should get index" do
    get editions_url
    assert_response :success
  end

  test "should get new" do
    get new_edition_url
    assert_response :success
  end

  test "should create edition" do
    assert_difference("Edition.count") do
      post editions_url, params: { edition: { category: @edition.category, desc: @edition.desc, name: @edition.name, rating: @edition.rating, url: @edition.url, user_id: @edition.user_id, verified: @edition.verified } }
    end

    assert_redirected_to edition_url(Edition.last)
  end

  test "should show edition" do
    get edition_url(@edition)
    assert_response :success
  end

  test "should get edit" do
    get edit_edition_url(@edition)
    assert_response :success
  end

  test "should update edition" do
    patch edition_url(@edition), params: { edition: { category: @edition.category, desc: @edition.desc, name: @edition.name, rating: @edition.rating, url: @edition.url, user_id: @edition.user_id, verified: @edition.verified } }
    assert_redirected_to edition_url(@edition)
  end

  test "should destroy edition" do
    assert_difference("Edition.count", -1) do
      delete edition_url(@edition)
    end

    assert_redirected_to editions_url
  end
end
