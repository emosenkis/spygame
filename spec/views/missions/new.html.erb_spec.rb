require 'spec_helper'

describe "missions/new" do
  before(:each) do
    assign(:mission, stub_model(Mission,
      :mission_template_id => 1
    ).as_new_record)
  end

  it "renders new mission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => missions_path, :method => "post" do
      assert_select "input#mission_mission_template_id", :name => "mission[mission_template_id]"
    end
  end
end
