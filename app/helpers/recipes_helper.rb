module RecipesHelper
  def recipe_header_img(recipe)
    content_tag(
      :div,
      nil,
      class: "recipe-header",
      style: "--bg-img-url: url('#{url_for(recipe.picture.variant(:medium))}')",
    )
  end
end
