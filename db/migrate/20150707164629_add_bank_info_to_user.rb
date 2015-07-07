class AddBankInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :bank_name, :string
    add_column :users, :bank_name_code, :integer
  end
end
