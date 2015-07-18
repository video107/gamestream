class Menu < ActiveRecord::Base

  belongs_to :category
  has_many :menu_users
  has_many :users, :through => :menu_users

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

  def followers?(owner)
    total_followers = []
    ios_followers = 0
    android_followers = 0
    if owner == "total"
      self.cases.each do |c|
        c.follow_users.each do |u|
          total_followers << u.email
        end
      end
      return total_followers.uniq.count
    elsif owner == "ios"
      self.cases.where(:owner => "ios").each do |c|
        ios_followers = ios_followers + c.follow_users.count
      end
      return ios_followers
    elsif owner == "android"
      self.cases.where(:owner => "android").each do |c|
        android_followers = android_followers + c.follow_users.count
      end
      return android_followers
    end
  end

  def to_now?
    self.created_at.to_date..Time.now.to_date
  end

  def total_click?(owner)
    ios_click = 0
    android_click = 0
    if owner == "ios"
      self.cases.where(:owner => "ios").each do |c|
        c.case_followers.each do |f|
          if f.repeat_click == nil || f.repeat_click == 0
            ios_click += 1
          else
            ios_click += f.repeat_click
          end
        end
      end
      return ios_click
    elsif owner == "android"
     self.cases.where(:owner => "android").each do |c|
        c.case_followers.each do |f|
          if f.repeat_click == nil || f.repeat_click == 0
            android_click += 1
          else
            android_click += f.repeat_click
          end
        end
      end
      return android_click
    end
  end



end
