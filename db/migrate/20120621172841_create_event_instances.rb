class CreateEventInstances < ActiveRecord::Migration
  def change
    create_table :event_instances do |t|
      t.integer :event_template_id
      t.integer :user_id
      t.integer :mission_instance_id

      t.timestamps
    end
    add_index :event_instances, :event_template_id
    add_index :event_instances, :mission_instance_id
    add_index :event_instances, :user_id
  end
end

