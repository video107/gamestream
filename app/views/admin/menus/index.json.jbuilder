json.array!(@admin_menus) do |admin_menu|
  json.extract! admin_menu, :id, :image, :name, :contents, :menu_url, :menu_url_ios, :game_pic, :game_pic_2, :game_pic_3, :game_pic_4, :game_pic_5, :game_pic_6, :game_icon
  json.url admin_menu_url(admin_menu, format: :json)
end
