class AdddefaultForUserEarnMoney < ActiveRecord::Migration
  def change
    change_column :users, :profit_money, :string, :default => "0"
    change_column :users, :total_earn_money, :string, :default => "0"
  end
end
