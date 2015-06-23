class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :fb_uid, :text
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :bank_account, :string
    add_index :users, :fb_uid
  end

end
