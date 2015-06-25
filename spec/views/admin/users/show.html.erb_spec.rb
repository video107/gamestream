require 'rails_helper'

RSpec.describe "admin/users/show", type: :view do
  before(:each) do
    @admin_user = assign(:admin_user, Admin::User.create!(
      :email => "Email",
      :name => "Name",
      :nickname => "Nickname",
      :phone => "Phone",
      :address => "Address",
      :bank_account => "Bank Account"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Bank Account/)
  end
end
