# == Schema Information
#
# Table name: mission_instances
#
#  id              :integer         not null, primary key
#  parent_template :integer
#  current_event   :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class MissionInstance < ActiveRecord::Base
  attr_accessible :mission_template_id

  has_one :mission_template
  has_many :users, :through => :user_mission
end
