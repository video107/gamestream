class AddGamePic6 < ActiveRecord::Migration
  def change
    add_attachment :menus, :game_pic_6
  end
end
