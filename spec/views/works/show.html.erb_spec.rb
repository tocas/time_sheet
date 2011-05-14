require 'spec_helper'

describe "works/show.html.erb" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :description => "Description",
      :time => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
