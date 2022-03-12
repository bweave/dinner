require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_password_url
    assert_response :success
  end

  test "create happy path" do
    skip
  end

  test "create handles not found users" do
    skip
  end

  test "create handles unconfirmed users" do
    skip
  end

  test "should get edit" do
    brian = users(:brian)
    brian.update! password_reset_sent_at: 1.minute.ago
    get edit_password_url(brian.password_reset_token)
    assert_response :success
  end

  test "update happy path" do
    brian = users(:brian)
    brian.update! password_reset_sent_at: 1.minute.ago
    params = {
      user: {
        password: "password",
        password_confirmation: "password",
      },
    }
    patch password_url(brian.password_reset_token), params: params
    assert_equal "Password updated successfully.", flash[:notice]
    assert_redirected_to login_url
  end

  test "update handles errors" do
    brian = users(:brian)
    brian.update! password_reset_sent_at: 1.minute.ago
    params = {
      user: {
        password: "password",
        password_confirmation: "does not match",
      },
    }
    patch password_url(brian.password_reset_token), params: params
    assert_equal "Password could not be updated. Please, try again.", flash[:alert]
    assert_template :edit
  end

  test "update handles unconfirmed users" do
    brian = users(:brian)
    brian.update! confirmed_at: nil, password_reset_sent_at: 1.minute.ago
    params = {
      user: {
        password: "password",
        password_confirmation: "password",
      },
    }
    patch password_url(brian.password_reset_token), params: params
    assert_equal "You must confirm your email before you can sign in.", flash[:notice]
    assert_redirected_to new_confirmation_url
  end

  test "update handles expired tokens" do
    brian = users(:brian)
    brian.update! password_reset_sent_at: User::PASSWORD_RESET_TOKEN_EXPIRATION_IN_SECONDS - 1.minute
    params = {
      user: {
        password: "password",
        password_confirmation: "password",
      },
    }
    patch password_url(brian.password_reset_token), params: params
    assert_equal "Expired password reset token.", flash[:notice]
    assert_redirected_to new_password_url
  end

  test "update handles not found users" do
    not_found_token = "does_not_exist_in_database"
    params = {
      password_reset_token: not_found_token,
      user: {
        password: "password",
        password_confirmation: "password",
      },
    }
    patch password_url(not_found_token), params: params
    assert_equal "We couldn't find a user with that token.", flash[:alert]
    assert_template :new
  end
end
