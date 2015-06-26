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


end
