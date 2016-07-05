require 'test_helper'

class BrowserControllerTest < ActionController::TestCase
  test "should get beers" do
    get :beers
    assert_response :success
  end

  test "should get pubs" do
    get :pubs
    assert_response :success
  end

end
