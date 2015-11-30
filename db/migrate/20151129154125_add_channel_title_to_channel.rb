class AddChannelTitleToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :channel_title, :string
  end
end
