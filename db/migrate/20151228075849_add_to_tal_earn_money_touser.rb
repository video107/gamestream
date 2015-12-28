class AddToTalEarnMoneyTouser < ActiveRecord::Migration
  def change
    add_column :users, :total_earn_money, :string
  end
end
