class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, :omniauth_providers => [:facebook]


  def self.from_omniauth(auth)
    user = where(provider: auth.provider, fb_uid: auth.uid).first

    unless user
      user = self.new
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name # assuming the user model has a name
      user.fb_image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
  end

end
