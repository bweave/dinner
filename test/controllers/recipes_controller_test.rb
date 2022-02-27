require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login users(:brian)
    with_household :weavers
    with_user :brian
    @recipe = recipes(:tacos)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    assert_difference("Recipe.unscoped.count") do
      recipe_params = {
        name: "Sandwiches",
        household_id: Household.current.id,
        created_by_id: User.current.id,
        edited_by_id: User.current.id,
      }
      post recipes_url, params: { recipe: recipe_params }
    end

    assert_redirected_to recipe_url(Recipe.unscoped.last)
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should update recipe" do
    recipe_params = { name: "Sandwiches" }
    patch recipe_url(@recipe), params: { recipe: recipe_params }
    assert_redirected_to recipe_url(@recipe)
  end

  test "should destroy recipe" do
    assert_difference("Recipe.unscoped.count", -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end
end
