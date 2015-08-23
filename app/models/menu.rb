class Menu < ActiveRecord::Base

  belongs_to :category
  # has_many :menu_users
  # has_many :users, :through => :menu_users
  has_paper_trail
  has_many :cases, :dependent => :destroy

  has_attached_file :game_image, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_image, :content_type => /\Aimage\/.*\Z/


  has_attached_file :game_pic, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_2, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_2, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_3, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_3, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_4, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_4, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_pic_5, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_pic_5, :content_type => /\Aimage\/.*\Z/

  has_attached_file :game_icon, :styles => { :large => "600x600>", :medium => "300x300>", :small => "250x250>", :thumb => "100x100>",:special => "70x70>" }, :default_url => "/images/:style/missing.png",
  :path => ":rails_root/public/system/menus/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :game_icon, :content_type => /\Aimage\/.*\Z/

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

  def to_now?
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

  def total_profit?(date1,date2)
    (self.total_click?("ios",date1,date2) * (self.cpc_ios ? self.cpc_ios : 0) + self.total_click?("android",date1,date2) * (self.cpc_android ? self.cpc_android : 0)) +
    (self.total_install?("ios",date1,date2) * (self.cpi_ios ? self.cpi_ios : 0) + self.total_install?("android",date1,date2) * (self.cpi_android ? self.cpi_android : 0)) +
    (self.total_excute?("ios",date1,date2) * (self.cpa_ios ? self.cpa_ios : 0) + self.total_excute?("android",date1,date2) * (self.cpa_android ? self.cpa_android : 0))
  end

  def total_net_profit?(date1,date2)
    # only cpc
    profit = self.cases.map { |cas| cas.total_profit?("customer",date1,date2)}.sum
    self.total_profit?(date1,date2) - profit
  end




end
