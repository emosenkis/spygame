class MissionTemplate < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :mission_instances
end
