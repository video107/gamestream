class AddBankBranchNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :bank_branch_name, :string
    change_column :users, :bank_name_code, :string
  end
end
