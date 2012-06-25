class CreateMissionInstances < ActiveRecord::Migration
  def change
    create_table :mission_instances do |t|
      t.integer :mission_template_id

      t.timestamps
    end
      add_index :mission_instances, :mission_template_id
  end
end
