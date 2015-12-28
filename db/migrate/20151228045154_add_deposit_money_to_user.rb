class AddDepositMoneyToUser < ActiveRecord::Migration
  def change
    add_column :users, :profit_money, :string
    rename_table :deposit_records, :withdraw_records
  end
end
