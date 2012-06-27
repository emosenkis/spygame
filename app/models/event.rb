# == Schema Information
#
# Table name: events
#
#  id                :integer         not null, primary key
#  event_template_id :integer
#  mission_id        :integer
#  user_id           :integer
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#


class Event < ActiveRecord::Base
  attr_accessible :event_template_id, :mission_id, :user_id
  
  belongs_to :mission
  belongs_to :event_template
  belongs_to :user
end
