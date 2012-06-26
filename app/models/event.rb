class Event < ActiveRecord::Base
  attr_accessible :description, :mission_id, :title, :user_id
  belongs_to :user
  belongs_to :mission
end
