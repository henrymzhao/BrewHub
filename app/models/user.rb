class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, uniqueness: true,
	format: {with: /\A[a-zA-Z]+\z/, message: "only allows letters"}
	validates :password, presence: true,
	length: {in: 6..20}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
    has_secure_password
end

user = User.new

user.valid? # => false
user.errors[:name]
# => ["can't be blank", "name already exists"]

user.errors.clear
user.errors.empty? # => true

user.errors[:password]
# => ["can't be blank", "must be within 6-20 characters"]
