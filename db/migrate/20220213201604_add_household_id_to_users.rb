class AddHouseholdIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :household, null: true, foreign_key: true
    User.find_each do |user|
      household = Household.find_or_create_by!(name: "#{user.last_name} Family")
      user.update!(household: household)
    end
    change_column_null :users, :household_id, false
  end
end
