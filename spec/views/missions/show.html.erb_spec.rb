require 'spec_helper'

describe "missions/show" do
  before(:each) do
    @mission = assign(:mission, stub_model(Mission,
      :mission_template_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end