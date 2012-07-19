class PositionLog < ActiveRecord::Base
  attr_accessible :game_state_id, :latitude, :longitude, :player_id
  belongs_to :player
  belongs_to :game_state
end
