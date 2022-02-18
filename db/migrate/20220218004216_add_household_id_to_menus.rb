class AddHouseholdIdToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :household, null: true, foreign_key: true
    household = Household.first
    Menu.unscoped.find_each do |menu|
      menu.update!(household: household)
    end
    change_column_null :menus, :household_id, false
  end
end
