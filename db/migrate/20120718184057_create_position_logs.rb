class CreatePositionLogs < ActiveRecord::Migration
  def change
    create_table :position_logs do |t|
      t.integer :game_state_id
      t.integer :player_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
