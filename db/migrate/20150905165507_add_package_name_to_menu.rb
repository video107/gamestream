class AddPackageNameToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :package_name, :string
  end
end
