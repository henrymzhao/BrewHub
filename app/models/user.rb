class User < ActiveRecord::Base
  #the user model.  converts characters into standard form, then checks against each other.
  before_save {self.email = email.downcase}

  #simple uname, name, email checking for valid characters.

  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :username, presence: true, length:{maximum: 50, minimum:4},
                       format:{with: VALID_USERNAME_REGEX},
                       uniqueness:true #case_sensitive:true is implied

  VALID_NAME_REGEX = /\A[a-zA-Z]+\z/
  validates :firstname, presence: true, length:{maximum: 50},
                        format:{with: VALID_NAME_REGEX}
  validates :lastname, presence: true, length:{maximum: 50},
                       format:{with: VALID_NAME_REGEX}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum: 50},
                    format:{with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive:false }

  #validate password.  Allows nil is required for facebook login - password cant be changed if it doesnt validate, other fields can.
  has_secure_password
  validates :password, presence: true, length:{minimum:6, maximum:30}, allow_nil: true

  DEFAULT_AVATAR = "../../assets/defaultavatar.png"
  def avatar
    read_attribute('avatar') || DEFAULT_AVATAR
  end


  def self.create_with_omniauth(auth)
    create! do |user|
      user.firstname = "example"
      user.lastname = "example"
      user.username = rand 10000000
      user.email = "#{user.username}@example.com"
      user.password = auth["uid"]
      user.password_confirmation = auth["uid"]
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.oauth_token = auth["credentials"]["token"]
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end


  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end
end
