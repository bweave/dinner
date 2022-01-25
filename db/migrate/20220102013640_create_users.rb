class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest, null: false
      t.string :confirmation_token, null: false
      t.datetime :confirmation_sent_at
      t.datetime :confirmed_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
