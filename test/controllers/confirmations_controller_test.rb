require "test_helper"

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_confirmation_url
    assert_response :success
  end

  test "should post create" do
    pene = users(:pene)
    post confirmations_url, params: {user: {email: pene.email}}
    assert_response :redirect, to: menus_url
  end

  test "should get edit" do
    brian = users(:brian)
    get edit_confirmation_url(brian.confirmation_token)
    assert_response :redirect, to: :menus_url
  end
end
