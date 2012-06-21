class MissionInstance < ActiveRecord::Base
  attr_accessible :current_event
  has_many :users, through: :user_missions
  has_many :event_instances
  belongs_to :mission_template
end
