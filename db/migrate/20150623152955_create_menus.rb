class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :image
      t.string :name
      t.text :contents

      t.timestamps null: false
    end
  end
end
