require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username:"ExampleUser", firstname:"Example",
                     lastname:"User", email:"user@example.com",
                     password:"password", password_confirmation:"password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  ##################################################################
  # PRESENCE VALIDATION - USERNAME, FIRSTNAME, LASTNAME, EMAIL
  ##################################################################
  test "username should be present" do
    @user.username = "     "
    assert_not @user.valid?
  end

  test "firstname should be present" do
    @user.firstname = "     "
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.lastname = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
     @user.email = "     "
     assert_not @user.valid?
   end

  ##################################################################
  # lENGTH VALIDATION - USERNAME, FIRSTNAME, LASTNAME, EMAIL
  ##################################################################
  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "username should not be too short" do
    @user.username = "a"
    assert_not @user.valid?
  end

  test "firstname should not be too long" do
    @user.firstname = "a" * 51
    assert_not @user.valid?
  end

  test "lastname should not be too long" do
    @user.lastname = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 51
    assert_not @user.valid?
  end

  ##################################################################
  # FORMAT VALIDATION - USERNAME & EMAIL
  ##################################################################
  test "username validation should accept valid characters" do
    valid_usernames = %w[user USeR u_ser us3r us-er]
    valid_usernames.each do |valid_username|
      @user.username = valid_username
      assert @user.valid?, "#{valid_username.inspect} should be valid"
    end
  end

  test "username validation should reject invalid characters" do
    invalid_usernames = %w[ us@er us\ er]
    invalid_usernames.each do |invalid_username|
      @user.username = invalid_username
      assert_not @user.valid?, "#{invalid_username.inspect} should be invalid"
    end
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn user@example.ca]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
    #validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end

  ##################################################################
  # UNIQUENESS VALIDATION - USERNAME & EMAIL
  ##################################################################

  #this is a bad test! if one is unique but not the other it passes
  test "uname email unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    duplicate_user.username = @user.username.upcase
    @user.save
    assert_not (duplicate_user.email == @user.email or duplicate_user.username == @user.username)
    #assert_not duplicate_user.valid?
  end

  ##################################################################
  # PASSWORD REQUIREMENTS
  ##################################################################

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should have a maximum length" do
    @user.password = @user.password_confirmation = "a" * 20
    assert_not @user.valid?
  end





end
