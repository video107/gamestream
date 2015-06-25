require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    assign(:admin_users, [
      Admin::User.create!(
        :email => "Email",
        :name => "Name",
        :nickname => "Nickname",
        :phone => "Phone",
        :address => "Address",
        :bank_account => "Bank Account"
      ),
      Admin::User.create!(
        :email => "Email",
        :name => "Name",
        :nickname => "Nickname",
        :phone => "Phone",
        :address => "Address",
        :bank_account => "Bank Account"
      )
    ])
  end

  it "renders a list of admin/users" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Bank Account".to_s, :count => 2
  end
end
