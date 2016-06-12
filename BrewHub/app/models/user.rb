class User < ActiveRecord::Base
  #attr_accessible :username, :email, :password, :password_confirmationv
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true #password_confirmation attr


  before_save :encrypt_password
  after_save :clear_password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def clear_password
    self.password = nil
  end
end
