class AddFriendlyId < ActiveRecord::Migration
  def change
    add_column :users, :friendly_id, :string
    add_column :menus, :friendly_id, :string
    add_column :cases, :friendly_id, :string

    add_index :users, :friendly_id, :unique => true
    add_index :menus, :friendly_id, :unique => true
    add_index :cases, :friendly_id, :unique => true
  end
end
