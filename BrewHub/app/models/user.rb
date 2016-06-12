class User < ActiveRecord::Base
  before_save {self.email = email.downcase}

  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :username, presence: true, length:{maximum: 50, minimum:4},
                       format:{with: VALID_USERNAME_REGEX},
                       uniqueness:true #case_sensitive:true is implied

  validates :firstname, presence: true, length:{maximum: 50}
  validates :lastname, presence: true, length:{maximum: 50}

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum: 50},
                    format:{with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive:false }

  has_secure_password
  validates :password, presence: true, length:{minimum:6, maximum:18}


end
