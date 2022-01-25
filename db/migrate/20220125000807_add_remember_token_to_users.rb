class AddRememberTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remember_token, :string
    User.find_each { |user| user.regenerate_remember_token }
    change_column_null :users, :remember_token, false

    add_index :users, :remember_token, unique: true
  end
end
