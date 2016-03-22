class Menu < ActiveRecord::Base

  belongs_to :category

  has_paper_trail
  has_many :cases, :dependent => :destroy
  scope :cpc, -> { where("cpc_ios_user != ? or cpc_android_user != ?", 0.0, 0.0)}
  scope :cpi, -> { where("cpi_ios_user != ? or cpi_android_user != ?", 0.0, 0.0)}
  scope :cpa, -> { where("cpa_ios_user != ? or cpa_android_user != ?", 0.0, 0.0)}


  has_attached_file :game_image, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_image, :content_type => /\Aimage\/.*\Z/


  has_attached_file :game_pic, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_2, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_2, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_3, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_3, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_4, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_4, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_5, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_5, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_6, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_6, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_icon, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "no_image.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_icon, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :friendly_id
  validates_uniqueness_of :friendly_id

  before_validation :setup_friendly_id

  attr_accessor :_remove_pic, :_remove_pic_2, :_remove_pic_3,
                :_remove_pic_4, :_remove_pic_5, :_remove_pic_6,
                :_remove_icon

  before_save :check_remove_pic
  before_save :check_remove_pic_2
  before_save :check_remove_pic_3
  before_save :check_remove_pic_4
  before_save :check_remove_pic_5
  before_save :check_remove_pic_6
  before_save :check_remove_icon

  def promote_higher(type)
    self.public_send("#{type}_ios_user") > self.public_send("#{type}_android_user") ? self.public_send("#{type}_ios_user") : self.public_send("#{type}_android_user")
  end

  def promote?(type)
      self.public_send("#{type}_android_user") != 0.0 || self.public_send("#{type}_ios_user") != 0.0
  end

  def case_url_with_user_and_owner(user, owner)
    self.cases.where(user: user, owner: owner).first.try(:case_url)
  end

  def to_param
    self.friendly_id
  end

  def setup_friendly_id
    self.friendly_id ||= SecureRandom.hex(3)
  end

  def followers?(owner,date1,date2)
    total_followers = 0
    ios_followers = 0
    android_followers = 0
    if owner == "total"
      self.cases.each do |c|
        c.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).each do |u|
          total_followers += 1
        end
      end
      return total_followers
    elsif owner == "ios"
      self.cases.where(:owner => "ios").each do |c|
        c.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).each do |u|
          ios_followers +=1
        end
      end
      return ios_followers
    elsif owner == "android"
      self.cases.where(:owner => "android").each do |c|
        c.case_followers.where("DATE(created_at) >= ? && DATE(created_at) <= ?", date1, date2).each do |u|
          android_followers +=1
        end
      end
      return android_followers
    end
  end

  def to_now
    self.created_at.to_date..Time.now.to_date
  end

  def total_click?(owner,date1,date2)
    self.cases.where(:owner => owner).map {|c| c.total_click?(date1,date2)}.sum
  end

  def total_install?(owner,date1,date2)
    self.cases.where(:owner => owner).map {|c| c.total_install?(date1,date2)}.sum
  end

  def total_excute?(owner,date1,date2)
    self.cases.where(:owner => owner).map {|c| c.total_excute?(date1,date2)}.sum
  end

  def total_import_users(owner,date1,date2)
    self.cases.where(:owner => owner).map {|c| c.import_by_date(date1,date2)}.sum
  end

  def total_profit?(date1,date2)
    self.total_click?("ios",date1,date2) * self.cpc_ios + self.total_click?("android",date1,date2) * self.cpc_android +
    self.total_install?("ios",date1,date2) * self.cpi_ios + self.total_install?("android",date1,date2) * self.cpi_android +
    self.total_excute?("ios",date1,date2) * self.cpa_ios + self.total_excute?("android",date1,date2) * self.cpa_android +
    self.total_import_users("ios",date1,date2) * self.cpl_ios + self.total_import_users("android",date1,date2) * self.cpl_android
  end

  def total_profit_no_repeat?(date1,date2)
    self.followers?("ios",date1,date2) * self.cpc_ios + self.followers?("android",date1,date2) * self.cpc_android +
    self.total_install?("ios",date1,date2) * self.cpi_ios + self.total_install?("android",date1,date2) * self.cpi_android +
    self.total_excute?("ios",date1,date2) * self.cpa_ios + self.total_excute?("android",date1,date2) * self.cpa_android +
    self.total_import_users("ios",date1,date2) * self.cpl_ios + self.total_import_users("android",date1,date2) * self.cpl_android
  end

  def total_cost?(date1,date2)
    self.total_click?("ios",date1,date2) * self.cpc_ios_user + self.total_click?("android",date1,date2) * self.cpc_android_user +
    self.total_install?("ios",date1,date2) * self.cpi_ios_user + self.total_install?("android",date1,date2) * self.cpi_android_user +
    self.total_excute?("ios",date1,date2) * self.cpa_ios_user + self.total_excute?("android",date1,date2) * self.cpa_android_user +
    self.total_import_users("ios",date1,date2) * self.cpl_ios_user + self.total_import_users("android",date1,date2) * self.cpl_android_user

  end

  def total_cost_no_repeat?(date1,date2)
    self.followers?("ios",date1,date2) * self.cpc_ios_user + self.followers?("android",date1,date2) * self.cpc_android_user +
    self.total_install?("ios",date1,date2) * self.cpi_ios_user + self.total_install?("android",date1,date2) * self.cpi_android_user +
    self.total_excute?("ios",date1,date2) * self.cpa_ios_user + self.total_excute?("android",date1,date2) * self.cpa_android_user +
    self.total_import_users("ios",date1,date2) * self.cpl_ios_user + self.total_import_users("android",date1,date2) * self.cpl_android_user
  end


  def total_net_profit?(date1,date2)
    self.total_profit?(date1,date2) - self.total_cost?(date1,date2)
  end

  def total_net_profit_no_repeat?(date1,date2)
    self.total_profit_no_repeat?(date1,date2) - self.total_cost_no_repeat?(date1,date2)
  end

  def total_net_profit_default?(date1,date2)
    self.total_profit?(date1,date2) - self.total_cost_no_repeat?(date1,date2)
  end

  def cpc?
    self.cpc_android != 0.0 || self.cpc_ios != 0.0
  end

  def cpl?
    self.cpl_android != 0.0 || self.cpl_ios != 0.0
  end

  def out_of_budget?
    self.budget < self.total_cost_no_repeat?(self.created_at.to_date, Date.today)
  end


  private

  def check_remove_pic
    if self._remove_pic == "1"
      self.game_pic = nil
    end
  end

  def check_remove_pic_2
    if self._remove_pic_2 == "1"
      self.game_pic_2 = nil
    end
  end

  def check_remove_pic_3
    if self._remove_pic_3 == "1"
      self.game_pic_3 = nil
    end
  end

  def check_remove_pic_4
    if self._remove_pic_4 == "1"
      self.game_pic_4 = nil
    end
  end

  def check_remove_pic_5
    if self._remove_pic_5 == "1"
      self.game_pic_5 = nil
    end
  end

  def check_remove_pic_6
    if self._remove_pic_6 == "1"
      self.game_pic_6 = nil
    end
  end

  def check_remove_icon
    if self._remove_icon == "1"
      self.game_icon = nil
    end
  end

end
