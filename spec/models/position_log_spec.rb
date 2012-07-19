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

require 'spec_helper'

describe PositionLog do
  pending "add some examples to (or delete) #{__FILE__}"
end
