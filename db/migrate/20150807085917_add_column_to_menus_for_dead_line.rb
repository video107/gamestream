class AddColumnToMenusForDeadLine < ActiveRecord::Migration
  def change
    add_column :menus, :cpc_android_user, :integer
    add_column :menus, :cpi_android_user, :integer
    add_column :menus, :cpa_android_user, :integer
    add_column :menus, :cpc_ios_user, :integer
    add_column :menus, :cpi_ios_user, :integer
    add_column :menus, :cpa_ios_user, :integer
    add_column :menus, :deadline, :date
  end
end
