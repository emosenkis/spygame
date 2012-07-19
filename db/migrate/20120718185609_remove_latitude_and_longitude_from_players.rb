class RemoveLatitudeAndLongitudeFromPlayers < ActiveRecord::Migration
  def up
    remove_column :players, :latitude
    remove_column :players, :longitude
  end

  def down
    add_column :players, :latitude, :float
    add_column :players, :longitude, :float
  end
end
