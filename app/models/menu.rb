class Menu < ActiveRecord::Base

  has_many :menu_users
  has_many :users, :through => :menu_users
end
