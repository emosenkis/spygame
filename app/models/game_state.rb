class GameState < ActiveRecord::Base
  attr_accessible :date_time_of_start, :game_template_id, :state

  belongs_to :game_template
  has_many :players
  has_many :position_logs

  def spy_update_time(interval=120)
    self.date_time_of_start + interval * ((Time.now - self.date_time_of_start) / interval).floor
  end
end
