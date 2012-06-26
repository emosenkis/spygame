require 'spec_helper'

describe "missions/index" do
  before(:each) do
    assign(:missions, [
      stub_model(Mission,
        :title => "Title",
        :description => "Description",
        :mission_id => 1
      ),
      stub_model(Mission,
        :title => "Title",
        :description => "Description",
        :mission_id => 1
      )
    ])
  end

  it "renders a list of missions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
