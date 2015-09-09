class CreateCaseInstallers < ActiveRecord::Migration
  def change
    create_table :case_installers do |t|
      t.integer :case_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :case_installers, :case_id
    add_index :case_installers, :user_id
  end
end
