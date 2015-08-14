class CreateDepositRecords < ActiveRecord::Migration
  def change
    create_table :deposit_records do |t|
      t.integer :amount, default: 0
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
