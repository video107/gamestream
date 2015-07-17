class AddRepeatCheckToCaseFollower < ActiveRecord::Migration
  def change
    add_column :case_followers, :repeat_click, :integer
    add_column :case_followers, :repeat_install, :integer
    add_column :case_followers, :repeat_excute, :integer
  end
end
