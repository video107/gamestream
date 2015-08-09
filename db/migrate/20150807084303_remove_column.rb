class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :case_followers, :cpi_check
    remove_column :case_followers, :cpa_check
    remove_column :case_followers, :repeat_click
    remove_column :case_followers, :repeat_install
    remove_column :case_followers, :repeat_excute
  end
end
