require 'test_no_db_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_redirected_to new_user_session_path
  end
end
