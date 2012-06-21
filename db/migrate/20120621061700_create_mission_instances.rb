class CreateMissionInstances < ActiveRecord::Migration
  def change
    create_table :mission_instances do |t|
      t.integer :parent_template
      t.integer :current_event

      t.timestamps
    end
  end
end
