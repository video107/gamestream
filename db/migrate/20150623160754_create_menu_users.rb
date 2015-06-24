class CreateMenuUsers < ActiveRecord::Migration
  def change
    create_table :menu_users do |t|
      t.integer :menu_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :menu_users, :menu_id
    add_index :menu_users, :user_id
  end
end
