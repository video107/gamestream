class Case < ActiveRecord::Base

  belongs_to :user
  belongs_to :menu

  has_many :case_followers, :dependent => :destroy
  has_many :follow_users, :through => :case_followers, :source => :user

  has_many :case_installers, :dependent => :destroy
  has_many :install_users, :through => :case_installers, :source => :user

  has_many :case_excuters, :dependent => :destroy
  has_many :excute_users, :through => :case_excuters, :source => :user

  has_many :case_click_install_excutes, :dependent => :destroy
  has_many :click_users, -> {where(:cpc => true)}, :class_name => "CaseClickInstallExcute"
  has_many :install_users, -> {where(:cpi => true)}, :class_name => "CaseClickInstallExcute"
  has_many :excute_users, -> {where(:cpa => true)}, :class_name => "CaseClickInstallExcute"


  validates_presence_of :friendly_id
  validates_uniqueness_of :friendly_id

  before_validation :setup_friendly_id



  def to_param
    self.friendly_id
  end

  def setup_friendly_id
    self.friendly_id ||= SecureRandom.hex(5)
  end

  def find_followed_by_user(user)
    self.case_followers.where(:user_id => user.id).first
  end

  def find_installed_by_user(user)
    self.case_installers.where(:user_id => user.id).first
  end

  def find_excuted_by_user(user)
    self.case_excuters.where(:user_id => user.id).first
  end

  def to_now?
    self.created_at.to_date..Time.now.to_date
  end

  def follower_by_date(date1,date2)
    self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def installer_by_date(date1,date2)
    self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def excuter_by_date(date1,date2)
    self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def total_click?(date1,date2)
   self.click_users.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count + self.follower_by_date(date1,date2)
  end

  def total_install?(date1,date2)
     self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def total_excute?(date1,date2)
     self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count
  end

  def total_profit?(user,date1,date2)
    if user == "admin"
      if self.owner == "android"
        return (self.menu.cpc_android * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpi_android * self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpa_android * self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      elsif self.owner == "ios"
        return (self.menu.cpc_ios * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpi_ios * self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpa_ios * self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      end
    elsif user == "customer"
      if self.owner == "android"
        return (self.menu.cpc_android_user * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpi_android_user * self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpa_android_user * self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      elsif self.owner == "ios"
        return (self.menu.cpc_ios_user * self.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpi_ios_user * self.case_installers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count) +
               (self.menu.cpa_ios_user * self.case_excuters.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).count)
      end
    end
  end



end
