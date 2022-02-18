class AddCreatedByToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :created_by, null: true, foreign_key: {to_table: :users}
    Household.find_each do |household|
      Household.current = household
      household.recipes.update_all(created_by_id: household.users.first.id)
    end
    change_column_null :recipes, :created_by_id, false
  end
end
