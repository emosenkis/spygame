class EventTemplate < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :parent_event, :radius, :title
  has_one :mission_template

end
	