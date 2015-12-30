class FixErrorColumnName < ActiveRecord::Migration
  def change
    rename_column :withdraw_records, :withdrawaler_nanme, :withdrawaler_name
  end
end
