class CreateEventInstances < ActiveRecord::Migration
  def change
    create_table :event_instances do |t|
      t.integer :parent_template

      t.timestamps
    end
  end
end
