class ChangeColumnToCases < ActiveRecord::Migration
  def change
    rename_column :cases, :url, :case_url
  end
end
