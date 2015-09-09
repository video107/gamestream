class CreateCaseExcuters < ActiveRecord::Migration
  def change
    create_table :case_excuters do |t|
      t.integer :case_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :case_excuters, :case_id
    add_index :case_excuters, :user_id
  end
end
