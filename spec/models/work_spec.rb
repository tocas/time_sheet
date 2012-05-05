# encoding: UTF-8
require 'spec_helper'

describe Work do
  before(:each) do
    @attr = { 
      :day => Date.today.to_s() , 
      :description => "My new job", 
      :time => 4,
      :user_id => 1 
    }
    Factory.build(:work)
    @work.save
  end

  it "should create a new instance given valid attributes" do
    @work.should be_valid
  end

  it "should require a user_id" do
    no_user_id = Work.new(@attr.merge(:user_id => ""))
    no_user_id.should_not be_valid
  end
  
  it "should reject description's that are too long" do
    long_desc = "a" * 256
    long_desc_work = Work.new(@attr.merge(:description => long_desc))
    long_desc_work.should_not be_valid
  end
  
  it "should reject negative time" do
    negative_time = -1
    negative_work = Work.new(@attr.merge(:time => negative_time))
    negative_work.should_not be_valid
  end
  
  it "should reject non date day" do
    non_day = "pátek"
    non_day_work = Work.new(@attr.merge(:day => non_day))
    non_day_work.should_not be_valid
  end
  
  it "should allow date whitch already exist" do
    work = Work.new(@attr.merge(:time => 3))
    work.save
    work.should be_valid
  end
end
