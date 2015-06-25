require 'rails_helper'

RSpec.describe "admin/menus/edit", type: :view do
  before(:each) do
    @admin_menu = assign(:admin_menu, Admin::Menu.create!(
      :image => "MyString",
      :name => "MyString",
      :contents => "MyText",
      :menu_url => "MyString",
      :menu_url_ios => "MyString",
      :game_pic => "MyString",
      :game_pic_2 => "MyString",
      :game_pic_3 => "MyString",
      :game_pic_4 => "MyString",
      :game_pic_5 => "MyString",
      :game_icon => "MyString"
    ))
  end

  it "renders the edit admin_menu form" do
    render

    assert_select "form[action=?][method=?]", admin_menu_path(@admin_menu), "post" do

      assert_select "input#admin_menu_image[name=?]", "admin_menu[image]"

      assert_select "input#admin_menu_name[name=?]", "admin_menu[name]"

      assert_select "textarea#admin_menu_contents[name=?]", "admin_menu[contents]"

      assert_select "input#admin_menu_menu_url[name=?]", "admin_menu[menu_url]"

      assert_select "input#admin_menu_menu_url_ios[name=?]", "admin_menu[menu_url_ios]"

      assert_select "input#admin_menu_game_pic[name=?]", "admin_menu[game_pic]"

      assert_select "input#admin_menu_game_pic_2[name=?]", "admin_menu[game_pic_2]"

      assert_select "input#admin_menu_game_pic_3[name=?]", "admin_menu[game_pic_3]"

      assert_select "input#admin_menu_game_pic_4[name=?]", "admin_menu[game_pic_4]"

      assert_select "input#admin_menu_game_pic_5[name=?]", "admin_menu[game_pic_5]"

      assert_select "input#admin_menu_game_icon[name=?]", "admin_menu[game_icon]"
    end
  end
end
