require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login users(:brian)
    with_household :weavers
    with_user :brian
    @user = users(:brian)
  end

  test "should get index" do
    skip "TODO: admin privileges"
    get users_url
    assert_response :success
  end

  test "should get new" do
    skip "TODO: admin privileges"
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    skip "TODO: admin privileges"
    assert_difference("User.count") do
      post users_url, params: { user: {} }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    skip "TODO: admin privileges"
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    user_params = {
      current_password: "password",
      first_name: "Scott",
    }
    patch user_url(@user), params: { user: user_params }
    assert_redirected_to edit_user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.unscoped.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end
end
