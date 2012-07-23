# == Schema Information
#
# Table name: position_logs
#
#  id            :integer         not null, primary key
#  game_state_id :integer
#  player_id     :integer
#  latitude      :float
#  longitude     :float
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class PositionLog < ActiveRecord::Base
  attr_accessible :game_state_id, :latitude, :longitude, :player_id
  belongs_to :player
  belongs_to :game_state
end
