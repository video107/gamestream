class AddAttachmentToMenus < ActiveRecord::Migration
  def change
    add_attachment :menus, :game_pic
    add_attachment :menus, :game_icon
  end
end
