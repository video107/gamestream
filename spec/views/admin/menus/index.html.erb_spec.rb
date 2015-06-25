require 'rails_helper'

RSpec.describe "admin/menus/index", type: :view do
  before(:each) do
    assign(:admin_menus, [
      Admin::Menu.create!(
        :image => "Image",
        :name => "Name",
        :contents => "MyText",
        :menu_url => "Menu Url",
        :menu_url_ios => "Menu Url Ios",
        :game_pic => "Game Pic",
        :game_pic_2 => "Game Pic 2",
        :game_pic_3 => "Game Pic 3",
        :game_pic_4 => "Game Pic 4",
        :game_pic_5 => "Game Pic 5",
        :game_icon => "Game Icon"
      ),
      Admin::Menu.create!(
        :image => "Image",
        :name => "Name",
        :contents => "MyText",
        :menu_url => "Menu Url",
        :menu_url_ios => "Menu Url Ios",
        :game_pic => "Game Pic",
        :game_pic_2 => "Game Pic 2",
        :game_pic_3 => "Game Pic 3",
        :game_pic_4 => "Game Pic 4",
        :game_pic_5 => "Game Pic 5",
        :game_icon => "Game Icon"
      )
    ])
  end

  it "renders a list of admin/menus" do
    render
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Menu Url".to_s, :count => 2
    assert_select "tr>td", :text => "Menu Url Ios".to_s, :count => 2
    assert_select "tr>td", :text => "Game Pic".to_s, :count => 2
    assert_select "tr>td", :text => "Game Pic 2".to_s, :count => 2
    assert_select "tr>td", :text => "Game Pic 3".to_s, :count => 2
    assert_select "tr>td", :text => "Game Pic 4".to_s, :count => 2
    assert_select "tr>td", :text => "Game Pic 5".to_s, :count => 2
    assert_select "tr>td", :text => "Game Icon".to_s, :count => 2
  end
end
