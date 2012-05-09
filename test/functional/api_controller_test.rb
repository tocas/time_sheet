require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  setup do
    
  end

  test "should get create" do
    get :log_time, activity_id: "12345", time: 60, user: "tomaslucovic@gmail.com"
    assert_select 'h1', "Prace byla ulozena"
    assert true
  end
end
