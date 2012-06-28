# == Schema Information
#
# Table name: event_templates
#
#  id                  :integer         not null, primary key
#  mission_template_id :integer
#  title               :string(255)
#  description         :text
#  parent_event_id     :integer
#  latitude            :float
#  longitude           :float
#  radius              :float
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#
 
class EventTemplate < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :mission_template_id, :parent_event_id, :radius, :title, :image

  belongs_to :mission_template
  has_one :parent_event, :class_name => "Event"
  has_many :events
end
