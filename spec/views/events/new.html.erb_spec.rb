require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :event_template_id => 1,
      :mission_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_event_template_id", :name => "event[event_template_id]"
      assert_select "input#event_mission_id", :name => "event[mission_id]"
      assert_select "input#event_user_id", :name => "event[user_id]"
    end
  end
end
