class Case < ActiveRecord::Base

  belongs_to :user
  belongs_to :menu

  has_many :case_followers
  has_many :follow_users, :through => :case_followers, :source => :user

  def find_followed_by_user(user)
    self.case_followers.where(:user_id => user.id).first
  end

  def to_now?
    self.created_at.to_date..Time.now.to_date
  end

  def total_click?
   total_click = 0
    self.case_followers.each do |f|
      if f.repeat_click == nil || f.repeat_click == 0
        total_click += 1
      else
        total_click += f.repeat_click
      end
    end
   return total_click
  end

end
