class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :url
      t.integer :user_id
      t.integer :menu_id

      t.timestamps null: false
    end
    add_index :cases, :user_id
    add_index :cases, :menu_id
  end
end
