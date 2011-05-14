require 'spec_helper'

describe "works/index.html.erb" do
  before(:each) do
    assign(:works, [
      stub_model(Work,
        :description => "Description",
        :time => 1
      ),
      stub_model(Work,
        :description => "Description",
        :time => 1
      )
    ])
  end

  it "renders a list of works" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
