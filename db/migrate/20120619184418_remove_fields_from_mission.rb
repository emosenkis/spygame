class RemoveFieldsFromMission < ActiveRecord::Migration
  def up
    remove_column :missions, :current_event
    remove_column :missions, :current_user
  end

  def down
    add_column :missions, :current_user, :integer
    add_column :missions, :current_event, :integer
  end
end
