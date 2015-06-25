class AddAttachmentToMenusMore < ActiveRecord::Migration
  def change
    add_column :menus, :menu_url_ios, :string
    add_attachment :menus, :game_pic_2
    add_attachment :menus, :game_pic_3
    add_attachment :menus, :game_pic_4
    add_attachment :menus, :game_pic_5
  end
end
