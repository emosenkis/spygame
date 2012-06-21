class UserMission < ActiveRecord::Base
  #add current event column
  belongs_to :user
  belongs_to :mission_instance

end
