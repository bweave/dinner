class AddHouseholdIdToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :household, null: true, foreign_key: true
    ScopedToHousehold.ignore do
      Recipe.unscoped.find_each do |recipe|
        household = Household.find_or_create_by!(name: "#{recipe.user.last_name} Family")
        recipe.update!(household: household)
      end
    end
    change_column_null :recipes, :household_id, false
  end
end
