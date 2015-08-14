class SetPriceDefaultToZero < ActiveRecord::Migration
  def change
    change_column :menus, :cpc_android, :integer , :default => 0
    change_column :menus, :cpc_ios, :integer , :default => 0
    change_column :menus, :cpi_android, :integer , :default => 0
    change_column :menus, :cpi_ios, :integer , :default => 0
    change_column :menus, :cpa_android, :integer , :default => 0
    change_column :menus, :cpa_ios, :integer , :default => 0
    change_column :menus, :cpc_android_user, :integer , :default => 0
    change_column :menus, :cpc_ios_user, :integer , :default => 0
    change_column :menus, :cpi_android_user, :integer , :default => 0
    change_column :menus, :cpi_ios_user, :integer , :default => 0
    change_column :menus, :cpa_android_user, :integer , :default => 0
    change_column :menus, :cpa_ios_user, :integer , :default => 0
  end
end
