class AddCostPropertyToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :cpc_android, :integer
    add_column :menus, :cpi_android, :integer
    add_column :menus, :cpa_android, :integer
    add_column :menus, :cpc_ios, :integer
    add_column :menus, :cpi_ios, :integer
    add_column :menus, :cpa_ios, :integer
    add_column :case_followers, :cpi_check, :string
    add_column :case_followers, :cpa_check, :string
  end
end
