require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "Login" 
    response.should be_success
    click_link "Register"
    response.should be_success
  end
  
  it "should have link to '/about' pate" do
    visit root_path
    click_link "About"
    response.should be_success
    response.should have_selector('title', :content => "About")
  end
  
  it "should have link to '/contact' pate" do
    visit root_path
    click_link "Contact"
    response.should be_success
    response.should have_selector('title', :content => "Contact")
  end
end
