class AddHouseholdIdToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :household, null: true, foreign_key: true
    ScopedToHousehold.ignore do
      household = Household.first
      Menu.unscoped.find_each do |menu|
        menu.update!(household: household)
      end
    end
    change_column_null :menus, :household_id, false
  end
end
