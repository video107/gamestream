class CreateImportMembers < ActiveRecord::Migration
  def change
    create_table :import_members do |t|
      t.integer :user_id
      t.integer :case_id
      t.integer :member_id

      t.timestamps null: false
    end
    add_column :menus, :cpl_android, :float, :default => 0
    add_column :menus, :cpl_ios, :float, :default => 0
    add_column :menus, :cpl_android_user, :float, :default => 0
    add_column :menus, :cpl_ios_user, :float, :default => 0
  end
end
