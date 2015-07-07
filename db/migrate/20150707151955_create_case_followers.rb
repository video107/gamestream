class CreateCaseFollowers < ActiveRecord::Migration
  def change
    create_table :case_followers do |t|
      t.integer :case_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :case_followers, :case_id
    add_index :case_followers, :user_id
  end
end
