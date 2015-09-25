class Addcpadefault < ActiveRecord::Migration
  def change
    change_column :menus, :cpa_period, :integer , :default => 1
  end
end
