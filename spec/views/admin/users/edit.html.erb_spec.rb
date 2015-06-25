require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do
  before(:each) do
    @admin_user = assign(:admin_user, Admin::User.create!(
      :email => "MyString",
      :name => "MyString",
      :nickname => "MyString",
      :phone => "MyString",
      :address => "MyString",
      :bank_account => "MyString"
    ))
  end

  it "renders the edit admin_user form" do
    render

    assert_select "form[action=?][method=?]", admin_user_path(@admin_user), "post" do

      assert_select "input#admin_user_email[name=?]", "admin_user[email]"

      assert_select "input#admin_user_name[name=?]", "admin_user[name]"

      assert_select "input#admin_user_nickname[name=?]", "admin_user[nickname]"

      assert_select "input#admin_user_phone[name=?]", "admin_user[phone]"

      assert_select "input#admin_user_address[name=?]", "admin_user[address]"

      assert_select "input#admin_user_bank_account[name=?]", "admin_user[bank_account]"
    end
  end
end
