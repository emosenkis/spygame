class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_state_id
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.string :role
      t.text :state

      t.timestamps
    end

    add_index :players, :game_state_id
    add_index :players, :user_id
  end
end
