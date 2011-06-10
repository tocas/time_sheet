require 'spec_helper'

describe User do
  before(:each) do
    @user_attr = Factory.attributes_for(:user)
  end

  it "should create a new instance of a user given valid attributes" do
    User.create!(@user_attr)
  end
  
  describe "admin" do
    it "should not be admin at default" do
      user = Factory(:user)
      user.admin.should be_false
    end
    
    it "should be admin" do
      user = User.create!(@user_attr.merge(:email => "test2@test.com"))
      user.update_attribute :admin, true
      user.admin.should be_true
    end
  end
end