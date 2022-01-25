class AddUserToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :user, null: true, foreign_key: true
    change_column_null :recipes, :user_id, false, User.first.id
  end
end
