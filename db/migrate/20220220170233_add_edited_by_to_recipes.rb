class AddEditedByToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :edited_by, null: true
    ScopedToHousehold.ignore do
      Household.find_each do |household|
        household.recipes.update_all(edited_by_id: household.users.first.id)
      end
    end
    change_column_null :recipes, :edited_by_id, false
  end
end
