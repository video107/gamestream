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

  def follower_by_date(date1,date2)
    self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end


  def total_click?(date1,date2)
   self.click_users.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count + self.follower_by_date(date1,date2)
  end

  def total_install?(date1,date2)
   self.install_users.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def total_excute?(date1,date2)
   self.excute_users.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def total_profit?(user,date1,date2)
    if user == "admin"
      if self.owner == "android"
        return ((self.menu.cpc_android ? self.menu.cpc_android : 0) * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      elsif self.owner == "ios"
        return ((self.menu.cpc_ios ? self.menu.cpc_ios : 0) * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      end
    elsif user == "customer"
      if self.owner == "android"
        ((self.menu.cpc_android_user ? self.menu.cpc_android_user : 0) * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      elsif self.owner == "ios"
        ((self.menu.cpc_ios_user ? self.menu.cpc_ios_user : 0) * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      end
    end
  end


end
