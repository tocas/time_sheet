require 'test_helper'
 
class UserFlowsTest < ActionDispatch::IntegrationTest
 
  test "login and browse site" do
    get "/users/sign_in"
    assert_response :success
 
    post_via_redirect "/users/sign_in", :username => "tomaslucovic@me.com", :password => "heslo123"
    assert_equal '/works', path
    assert_response :success
  end
end