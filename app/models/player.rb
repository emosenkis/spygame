class Player < ActiveRecord::Base
  attr_accessible :game_state_id, :role, :state, :user_id, :latitude, :longitude

  belongs_to :user
  belongs_to :game_state
end
