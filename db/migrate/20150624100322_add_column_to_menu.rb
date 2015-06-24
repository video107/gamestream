class AddColumnToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :menu_url, :string
  end
end
