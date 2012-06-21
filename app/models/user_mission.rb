class UserMission < ActiveRecord::Base
  attr_accessible :current_event_id, :mission_instance_id, :user_id
end
