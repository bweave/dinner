module RecipesHelper
  def recipe_header_img(recipe)
    content_tag(
      :div,
      nil,
      style: <<~STYLE.squish,
        heigh:0;
        padding-top:56.25%;
        background-image:url(#{url_for(recipe.picture.variant(:medium))});
        background-size:cover;
      STYLE
    )
  end
end
