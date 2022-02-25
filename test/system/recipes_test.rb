require "application_system_test_case"

class RecipesTest < ApplicationSystemTestCase
  setup do
    login users(:brian)
    @recipe = recipes(:tacos)
  end

  test "visiting the index" do
    visit recipes_url
    assert_selector "h5", text: @recipe.name
  end

  test "should create recipe" do
    visit recipes_url
    refute_selector "h5", text: "Sandwiches"
    click_on "New recipe"
    fill_in "Name", with: "Sandwiches"
    click_on "Create Recipe"
    assert_selector "h1", text: "Sandwiches"
  end

  test "should update Recipe" do
    visit recipe_url(@recipe)
    assert_selector "h1", text: @recipe.name
    click_link "Edit"
    fill_in "Name", with: "Sandwiches"
    click_on "Update Recipe"
    assert_selector "h1", text: "Sandwiches"
  end

  test "should destroy Recipe" do
    visit recipe_url(@recipe)
    click_on "Delete"
    refute_text @recipe.name
  end
end
