class EventTemplate < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :mission_template_id, :parent_event_id, :radius, :title
end
