class AddCreatedByToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :created_by, null: true, foreign_key: {to_table: :users}
    Household.find_each do |household|
      Household.current = household
      household.menus.update_all(created_by_id: household.users.first.id)
    end
    change_column_null :menus, :created_by_id, false
  end
end
