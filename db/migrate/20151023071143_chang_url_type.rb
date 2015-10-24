class ChangUrlType < ActiveRecord::Migration
  def change
    remove_column :channels, :url
    add_column :channels, :url, :text
  end
end
