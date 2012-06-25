# == Schema Information
#
# Table name: mission_templates
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class MissionTemplate < ActiveRecord::Base
  attr_accessible :description, :name
end
