class AddCpaPeriod < ActiveRecord::Migration
  def change
    add_column :menus, :cpa_period, :integer 
  end
end
