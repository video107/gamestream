class AddAuthorToCase < ActiveRecord::Migration
  def change
    add_column :cases, :owner, :string
  end
end
