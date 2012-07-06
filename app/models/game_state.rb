class GameState < ActiveRecord::Base
  attr_accessible :date_time_of_start, :game_template_id

  belongs_to :game_template
  has_many :players
end
