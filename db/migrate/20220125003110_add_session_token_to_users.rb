class AddSessionTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :session_token, :string
    User.unscoped.find_each { |user| user.regenerate_session_token }
    change_column_null :users, :session_token, false

    add_index :users, :session_token, unique: true
  end
end
