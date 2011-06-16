require 'spec_helper'

describe "settings/index.html.erb" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        :name => "Name",
        :APIkey => "Ap Ikey"
      ),
      stub_model(Setting,
        :name => "Name",
        :APIkey => "Ap Ikey"
      )
    ])
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ap Ikey".to_s, :count => 2
  end
end
