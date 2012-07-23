# == Schema Information
#
# Table name: game_templates
#
#  id          :integer         not null, primary key
#  class_name  :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class GameTemplate < ActiveRecord::Base
  attr_accessible :class_name, :name, :description

  has_many :game_states

end
