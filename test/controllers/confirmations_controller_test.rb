require "test_helper"

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get confirmations_new_url
    assert_response :success
  end

  test "should get create" do
    get confirmations_create_url
    assert_response :success
  end

  test "should get edit" do
    get confirmations_edit_url
    assert_response :success
  end
end
