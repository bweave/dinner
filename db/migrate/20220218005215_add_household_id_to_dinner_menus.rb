class AddHouseholdIdToDinnerMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :dinner_menus, :household, null: true, foreign_key: true
    Household.current = Household.first
    DinnerMenu.unscoped.find_each do |dinner_menu|
      dinner_menu.update!(household: Household.current)
    end
    change_column_null :dinner_menus, :household_id, false
  end
end
