class AddBudgetToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :budget, :integer, :default => 1000000
  end
end
