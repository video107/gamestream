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
  has_many :withdraw_records
  has_many :channels, :dependent => :destroy

  validates_presence_of :friendly_id
  validates_uniqueness_of :friendly_id

  before_validation :setup_friendly_id

  def total_click?(date1, date2) # clicks of all cases under user
    self.cases.map { |x| x.follower_by_date(date1, date2)}.sum
  end

  def total_install?(date1, date2) # clicks of all cases under user
    self.cases.map { |x| x.installer_by_date(date1, date2)}.sum
  end

  def total_excute?(date1, date2) # clicks of all cases under user
    self.cases.map { |x| x.excuter_by_date(date1, date2)}.sum
  end

  def total_profit? # all profits (cpc/cpi/cpa) of cases under user from created day to deadline
    self.cases.map { |x| x.total_profit?("customer", x.created_at.to_date, x.menu.deadline)}.sum
  end

  def total_profit_by_date?(date1, date2) # all profits (cpc/cpi/cpa) of cases under user from date1 to date2
    self.cases.map { |x| x.total_profit?("customer", date1, date2)}.sum
  end

  def to_param
    self.friendly_id
  end

  def setup_friendly_id
    self.friendly_id ||= SecureRandom.hex(3)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.fb_image = auth.info.image # assuming the user model has an image
      user.google_uid = auth.uid
      user.twitch_account_url = "http://www.twitch.tv/example"
      user.youtube_account_url = "https://www.youtube.com/watch?v=example"
      user.save!
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

  def withdraw?
    self.withdraw_records.all.map { |x| x.amount}.sum
  end




  protected

  def validate_account_url
    errors.add(:twitch, "twitch帳號格式有誤") unless self.twitch_account_url =~ /http:\/\/www.twitch.tv\/.+/ || self.twitch_account_url == ""
    errors.add(:youtube, "youtube帳號格式有誤") unless self.youtube_account_url =~ /https:\/\/.*youtube.com\/watch\?v=.+/ || self.youtube_account_url == ""
  end



end
