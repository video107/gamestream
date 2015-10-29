class AddUrlForUserAccount < ActiveRecord::Migration
  def change
    add_column :users, :twitch_account_url, :string
    add_column :users, :youtube_account_url, :string
  end
end
