class Mission < ActiveRecord::Base
  attr_accessible :description, :mission_id, :title
  has_many :events
  has_many :users, through: :events
end
