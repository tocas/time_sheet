require 'spec_helper'

describe "works/edit.html.erb" do
  before(:each) do
    @work = assign(:work, stub_model(Work,
      :description => "MyString",
      :time => 1
    ))
  end

  it "renders the edit work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => works_path(@work), :method => "post" do
      assert_select "input#work_description", :name => "work[description]"
      assert_select "input#work_time", :name => "work[time]"
    end
  end
end
