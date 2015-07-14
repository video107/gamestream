class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]


  has_many :menu_users
  has_many :menus, :through => :menu_users

  has_many :cases, :dependent => :destroy

  has_many :case_followers
  has_many :follow_cases, :through => :case_followers, :source => :case
  has_paper_trail

  # def self.from_omniauth(auth)
  #   user = where(provider: auth.provider, google_uid: auth.uid).first
  #   unless user
  #     user = self.new
  #     user.fb_uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     # user.name = auth.info.name # assuming the user model has a name
  #     user.fb_image = auth.info.image # assuming the user model has an image
  #     user.save!
  #   end
  #   user
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.fb_image = auth.info.image # assuming the user model has an image
      user.google_uid = auth.uid
    end
  end



  def has_right?
    self.role == nil || self.role == "normal"
  end


  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
  end

  def user_name
    if self
       self.nickname || self.name || self.email.split("@").first
    else
      "Guest"
    end
  end





end
