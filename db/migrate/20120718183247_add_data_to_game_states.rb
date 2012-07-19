class AddDataToGameStates < ActiveRecord::Migration
  def up
    add_column :game_states, :data, :text
    change_column :game_states, :state, :string
  end
  def down
    remove_column :game_states, :data
    change_column :game_states, :state, :text
  end
end
