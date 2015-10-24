class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :url, null: false


      t.timestamps null: false
    end
  end
end
