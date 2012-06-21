class EventInstance < ActiveRecord::Base
  has_one :user, :event_template
  belongs_to :mission_instance

end
