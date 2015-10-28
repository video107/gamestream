class AddViewersCountForChannel < ActiveRecord::Migration
  def change
    add_column :channels, :viewers, :integer
  end
end
