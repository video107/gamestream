class Case < ActiveRecord::Base

  belongs_to :user
  belongs_to :menu

  has_many :case_followers, :dependent => :destroy
  has_many :follow_users, :through => :case_followers, :source => :user

  has_many :case_click_install_excutes, :dependent => :destroy
  has_many :click_users, -> {where(:cpc => true)}, :class_name => "CaseClickInstallExcute"
  has_many :install_users, -> {where(:cpi => true)}, :class_name => "CaseClickInstallExcute"
  has_many :excute_users, -> {where(:cpa => true)}, :class_name => "CaseClickInstallExcute"


  def find_followed_by_user(user)
    self.case_followers.where(:user_id => user.id).first
  end

  def to_now?
    self.created_at.to_date..Time.now.to_date
  end

  def total_click?
   self.click_users.count
  end


  def total_click_day?(date)
    clicks_day = 0
   self.click_users.each do |c|
    if c.created_at.to_date == date
      clicks_day +=1
    end
   end
   return clicks_day
  end

  def case_followers_day?(date)
    followers_day = 0
    self.case_followers.each do |c|
      if c.created_at.to_date == date
        followers_day += 1
      end
    end
    return followers_day
  end

end
