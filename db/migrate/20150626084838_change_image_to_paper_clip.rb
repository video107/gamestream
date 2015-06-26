class ChangeImageToPaperClip < ActiveRecord::Migration
  def change
    remove_column :menus, :image
    add_attachment :menus, :game_image
  end
end
