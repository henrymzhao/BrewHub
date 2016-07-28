require 'test_helper'

class SocialControllerTest < ActionController::TestCase
  test "should get meetup" do
    get :meetup
    assert_response :success
  end

  test "should get closest" do
    get :closest
    assert_response :success
  end

end
