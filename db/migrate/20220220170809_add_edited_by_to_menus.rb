class AddEditedByToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :edited_by, null: true, foreign_key: {to_table: :users}
    ScopedToHousehold.ignore do
      Household.find_each do |household|
        household.menus.update_all(edited_by_id: household.users.first.id)
      end
    end
    change_column_null :menus, :edited_by_id, false
  end
end
