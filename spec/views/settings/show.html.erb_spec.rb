require 'spec_helper'

describe "settings/show.html.erb" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
      :name => "Name",
      :APIkey => "Ap Ikey"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ap Ikey/)
  end
end
