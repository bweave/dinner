class AddPasswordResetTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_reset_sent_at, :datetime

    add_column :users, :password_reset_token, :string
    User.find_each { |user| user.regenerate_password_reset_token }
    change_column_null :users, :password_reset_token, false

    add_index :users, :password_reset_token, unique: true
  end
end
