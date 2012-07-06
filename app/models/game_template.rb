class GameTemplate < ActiveRecord::Base
  attr_accessible :class_name, :name, :description

  has_many :game_states

end
