require "test_helper"

class MenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    login users(:brian)
    with_household :weavers
    with_user :brian
    @menu = menus(:this_week)
  end

  test "should get index" do
    get menus_url
    assert_response :success
  end

  test "should get new" do
    get new_menu_url
    assert_response :success
  end

  test "should create menu" do
    assert_difference("Menu.unscoped.count") do
      menu_params = {
        starts_at: Time.current.beginning_of_week,
        created_by_id: User.current.id,
        edited_by_id: User.current.id,
        household_id: Household.current.id,
        recipe_ids: [recipes(:tacos).id],
      }
      post menus_url, params: { menu: menu_params }
    end

    assert_redirected_to menus_url
  end

  test "should show menu" do
    get menu_url(@menu)
    assert_response :success
  end

  test "should get edit" do
    get edit_menu_url(@menu)
    assert_response :success
  end

  test "should update menu" do
    patch menu_url(@menu), params: { menu: { starts_at: @menu.starts_at, recipe_ids: [recipes(:burgers).id] } }
    assert_redirected_to menus_url
  end

  test "should destroy menu" do
    assert_difference("Menu.unscoped.count", -1) do
      delete menu_url(@menu)
    end

    assert_redirected_to menus_url
  end
end
