require "application_system_test_case"

class MenusTest < ApplicationSystemTestCase
  setup do
    login users(:brian)
    @menu = menus(:this_week)
  end

  test "visiting the index" do
    visit menus_url
    assert_selector "h2", text: @menu.title
  end

  test "should create menu" do
    visit menus_url
    refute_selector "h5", text: "Burgers"
    click_on "New menu"
    check "Burgers"
    click_on "Create Menu"
    assert_selector "h5", text: "Burgers"
  end

  test "should update Menu" do
    visit menu_url(@menu)
    assert_selector "h5", text: "Tacos"
    click_link "Edit this menu", match: :first
    uncheck "Tacos"
    click_on "Update Menu"
    refute_selector "h5", text: "Tacos"
  end

  test "should destroy Menu" do
    visit menu_url(@menu)
    assert_selector "h5", text: "Tacos"
    click_button "Delete this menu", match: :first
    refute_selector "h5", text: "Tacos"
  end
end
