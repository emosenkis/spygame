# == Schema Information
#
# Table name: players
#
#  id            :integer         not null, primary key
#  game_state_id :integer
#  user_id       :integer
#  role          :string(255)
#  state         :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Player < ActiveRecord::Base
  attr_accessible :game_state_id, :role, :state, :user_id

  belongs_to :user
  belongs_to :game_state
  has_many :position_logs
  def update_position(latitude, longitude)
    log=self.position_logs.new
    log.game_state_id=self.game_state_id
    log.latitude=latitude
    log.longitude=longitude
    log.save
  end
  def latest_position(before = nil)
    if before.nil?
      position=self.position_logs.order('created_at DESC').limit(1).first
    else
      position=self.position_logs.where('created_at < ?', before).order('created_at DESC').limit(1).first
    end
    position || PositionLog.new
  end
end
