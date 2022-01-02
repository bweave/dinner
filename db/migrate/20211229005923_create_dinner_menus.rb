class CreateDinnerMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :dinner_menus do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
