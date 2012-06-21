class EventInstance < ActiveRecord::Base
  attr_accessible :event_template_id, :mission_instance_id, :user_id
end
