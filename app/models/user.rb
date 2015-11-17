 class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and, :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  validate :validate_account_url

  has_many :cases, :dependent => :destroy

  has_many :case_followers, :dependent => :destroy
  has_many :follow_cases, :through => :case_followers, :source => :case, :dependent => :destroy
  has_paper_trail

  has_many :case_click_install_excutes, :dependent => :destroy
  has_many :clicks, -> {where(:cpc => true)}, :class_name => "CaseClickInstallExcute"
  has_many :installs, -> {where(:cpi => true)}, :class_name => "CaseClickInstallExcute"
  has_many :excutes, -> {where(:cpa => true)}, :class_name => "CaseClickInstallExcute"
  has_many :deposit_records
  has_many :channels, :dependent => :destroy

  validates_presence_of :friendly_id
  validates_uniqueness_of :friendly_id

  before_validation :setup_friendly_id

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

  def find_channel_by_user(user, provider)
    self.channels.where(user: user, name: provider).first
  end

  def to_param
    self.friendly_id
  end

  def setup_friendly_id
    self.friendly_id ||= SecureRandom.hex(6)
  end

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

  def self.emails_all
    emails = []
    all.each do |user|
      emails << user.email
    end
    emails
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
      if self.nickname.blank?
        self.name
      elsif self.nickname.blank? && self.name.blank?
        self.email.split("@").first
      else
        self.nickname
      end
    else
      "Guest"
    end
  end

  def deposit?
    self.deposit_records.all.map { |x| x.amount}.sum
  end


  protected

  def validate_account_url
    errors.add(:twitch, "twitch帳號格式有誤") unless self.twitch_account_url =~ /http:\/\/www.twitch.tv\/.+/
    errors.add(:youtube, "youtube帳號格式有誤") unless self.youtube_account_url =~ /https:\/\/gaming.youtube.com\/watch\?v=.+/
  end



end
