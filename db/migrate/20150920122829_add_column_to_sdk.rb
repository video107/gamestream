class AddColumnToSdk < ActiveRecord::Migration
  def change
    add_column :sdks, :android_id, :string
    add_column :sdks, :screensize, :string
    add_column :sdks, :imsi, :string
    add_column :sdks, :retry, :integer
  end
end
