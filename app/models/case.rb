class Case < ActiveRecord::Base

  belongs_to :user
  belongs_to :menu

  has_many :case_followers
  has_many :follow_users, :through => :case_followers, :source => :user

end
