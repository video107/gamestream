class AddChannelUserNameToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :broadcaster_name, :string
  end
end
