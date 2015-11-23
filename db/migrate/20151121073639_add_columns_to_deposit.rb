class AddColumnsToDeposit < ActiveRecord::Migration
  def change
    add_column :deposit_records, :withdrawaler_nanme, :string
    add_column :deposit_records, :withdrawaler_phone, :string
    add_column :deposit_records, :withdrawaler_bank_name, :string
    add_column :deposit_records, :withdrawaler_bank_branch_name, :string
    add_column :deposit_records, :withdrawaler_bank_name_code, :string
    add_column :deposit_records, :withdrawaler_bank_account, :string
  end
end
