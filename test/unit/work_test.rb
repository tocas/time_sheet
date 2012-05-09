# coding: UTF-8
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should create new work" do
    work = Factory.build(:work)
    assert work.save
  end
  
  test "should required user id" do 
    work = Work.new(Factory.attributes_for(:work).merge(:user_id => " "))
    assert !work.save
  end
  
  test "should reject description's that are too long" do
    long_desc = "a" * 256
    work = Work.new(Factory.attributes_for(:work).merge(:description => long_desc))
    assert !work.save
  end
  
  test "should reject negative time" do
    time = -1
    work = Work.new(Factory.attributes_for(:work).merge(:time => time))
    assert !work.save
  end
  
  test "should reject non date day" do
    non_day = "pátek"§
    work = Work.new(Factory.attributes_for(:work).merge(:day => non_day))
    assert !work.save
  end
end
