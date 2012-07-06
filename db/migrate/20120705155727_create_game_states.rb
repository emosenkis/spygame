class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.datetime :date_time_of_start
      t.integer :game_template_id
      t.text :state

      t.timestamps
    end
    add_index :game_states, :game_template_id
    add_index :game_states, :date_time_of_start
  end
end
