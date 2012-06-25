# == Schema Information
#
# Table name: event_instances
#
#  id              :integer         not null, primary key
#  parent_template :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class EventInstance < ActiveRecord::Base
  attr_accessible :event_template_id, :mission_instance_id, :user_id
  
  has_one :mission_instance
  has_one :event_template
  has_one :user
end
