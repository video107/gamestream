class DropUselessTable < ActiveRecord::Migration
  def change
    drop_table :menu_users
  end
end
