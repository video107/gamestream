class ChangePriceToFloat < ActiveRecord::Migration
  def change
    change_column :menus, :cpc_android, :float , :default => 0
    change_column :menus, :cpc_ios, :float , :default => 0
    change_column :menus, :cpi_android, :float , :default => 0
    change_column :menus, :cpi_ios, :float , :default => 0
    change_column :menus, :cpa_android, :float , :default => 0
    change_column :menus, :cpa_ios, :float , :default => 0
    change_column :menus, :cpc_android_user, :float , :default => 0
    change_column :menus, :cpc_ios_user, :float , :default => 0
    change_column :menus, :cpi_android_user, :float , :default => 0
    change_column :menus, :cpi_ios_user, :float , :default => 0
    change_column :menus, :cpa_android_user, :float , :default => 0
    change_column :menus, :cpa_ios_user, :float , :default => 0
  end
end
