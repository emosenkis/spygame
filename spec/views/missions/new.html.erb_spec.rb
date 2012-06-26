require 'spec_helper'

describe "missions/new" do
  before(:each) do
    assign(:mission, stub_model(Mission,
      :title => "MyString",
      :description => "MyString",
      :mission_id => 1
    ).as_new_record)
  end

  it "renders new mission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => missions_path, :method => "post" do
      assert_select "input#mission_title", :name => "mission[title]"
      assert_select "input#mission_description", :name => "mission[description]"
      assert_select "input#mission_mission_id", :name => "mission[mission_id]"
    end
  end
end
