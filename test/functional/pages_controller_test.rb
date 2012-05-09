require 'test_no_db_helper'

class PagesControllerTest < ActionController::TestCase

  test "should get home" do
    get :home
    assert_select 'title', "Time Sheet | Home"
    assert_select 'ul.nav' do
      assert_select 'li', "Login"
      assert_select 'li', "Register"
    end
    assert_response :success
  end
end
