# == Schema Information
#
# Table name: missions
#
#  id                  :integer         not null, primary key
#  mission_template_id :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#
class Mission < ActiveRecord::Base
  attr_accessible :mission_template_id

  belongs_to :mission_template
  has_many :events
  has_many :users, :through => :user_mission
end

