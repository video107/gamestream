class AddDefaultToCpCCpICpA < ActiveRecord::Migration
  def change
    change_column :case_followers, :repeat_click, :integer, :default => 0
    change_column :case_followers, :repeat_install, :integer,  :default => 0
    change_column :case_followers, :repeat_excute, :integer,  :default => 0
  end
end
