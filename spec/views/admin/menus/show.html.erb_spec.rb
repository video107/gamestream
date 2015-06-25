require 'rails_helper'

RSpec.describe "admin/menus/show", type: :view do
  before(:each) do
    @admin_menu = assign(:admin_menu, Admin::Menu.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Menu Url/)
    expect(rendered).to match(/Menu Url Ios/)
    expect(rendered).to match(/Game Pic/)
    expect(rendered).to match(/Game Pic 2/)
    expect(rendered).to match(/Game Pic 3/)
    expect(rendered).to match(/Game Pic 4/)
    expect(rendered).to match(/Game Pic 5/)
    expect(rendered).to match(/Game Icon/)
  end
end
