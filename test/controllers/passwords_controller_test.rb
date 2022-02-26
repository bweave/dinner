require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    skip
    get passwords_new_url
    assert_response :success
  end

  test "should get create" do
    skip
    get passwords_create_url
    assert_response :success
  end

  test "should get edit" do
    skip
    get passwords_edit_url
    assert_response :success
  end

  test "should get update" do
    skip
    get passwords_update_url
    assert_response :success
  end
end
