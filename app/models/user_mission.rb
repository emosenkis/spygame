# == Schema Information
#
# Table name: user_missions
#
#  id               :integer         not null, primary key
#  user_id          :integer
#  mission_id       :integer
#  current_event_id :integer
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#


class UserMission < ActiveRecord::Base
  attr_accessible :current_event_id, :mission_id, :user_id
  
  belongs_to :user
  belongs_to :mission
end
