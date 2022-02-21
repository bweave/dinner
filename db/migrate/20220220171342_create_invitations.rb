class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :household, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :email, null: false
      t.timestamp :sent_at
      t.timestamp :accepted_at
      t.string :token, null: false
      t.references :created_by, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end

    add_index :invitations, :token, unique: true
  end
end
