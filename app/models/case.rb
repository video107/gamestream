class Case < ActiveRecord::Base

  belongs_to :user
  belongs_to :menu

  has_many :case_followers
  has_many :follow_users, :through => :case_followers, :source => :user

  def find_followed_by_user(user)
    self.case_followers.where(:user_id => user.id).first
  end



end
