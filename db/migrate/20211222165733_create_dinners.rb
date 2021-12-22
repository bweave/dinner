class CreateDinners < ActiveRecord::Migration[7.0]
  def change
    create_table :dinners do |t|
      t.string :name
      t.datetime :last_suggested_at

      t.timestamps
    end
  end
end
