class CreateCaseClickInstallExcutes < ActiveRecord::Migration
  def change
    create_table :case_click_install_excutes do |t|
      t.integer :user_id
      t.integer :case_id
      t.string :cpc, :defautt => :false
      t.string :cpi, :defautt => :false
      t.string :cpa, :defautt => :false

      t.timestamps null: false
    end
    add_index :case_click_install_excutes, :user_id
    add_index :case_click_install_excutes, :case_id
  end
end
