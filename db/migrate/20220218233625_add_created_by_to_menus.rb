class AddCreatedByToMenus < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :created_by, null: true
    ScopedToHousehold.ignore do
      Household.find_each do |household|
        household.menus.update_all(created_by_id: household.users.first.id)
      end
    end
  end
end
