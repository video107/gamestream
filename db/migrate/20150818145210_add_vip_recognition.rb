class AddVipRecognition < ActiveRecord::Migration
  def change
    add_column :users, :fans, :string
    add_column :users, :master, :string
  end
end
