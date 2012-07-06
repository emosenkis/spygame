class GameTemplate < ActiveRecord::Base
  attr_accessible :class_name

  has_many :game_states
  
end
