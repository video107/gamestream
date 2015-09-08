class CreateSdks < ActiveRecord::Migration
  def change
    create_table :sdks do |t|
      t.string :package_name
      t.string :build_id
      t.string :device_model
      t.string :board
      t.string :device
      t.string :build_serial
      t.string :device_version
      t.string :sdk_version
      t.string :incremental
      t.string :google_account
      t.string :imei
      t.string :mac_addr
      t.string :google_advertisingid
      t.timestamps null: false
    end
  end
end
