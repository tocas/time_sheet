require 'spec_helper'

describe "works/new.html.erb" do
  before(:each) do
    assign(:work, stub_model(Work,
      :description => "MyString",
      :time => 1
    ).as_new_record)
  end

  it "renders new work form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => works_path, :method => "post" do
      assert_select "input#work_description", :name => "work[description]"
      assert_select "input#work_time", :name => "work[time]"
    end
  end
end
