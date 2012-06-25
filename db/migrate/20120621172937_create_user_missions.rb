class CreateUserMissions < ActiveRecord::Migration
  def change
    create_table :user_missions do |t|
      t.integer :user_id
      t.integer :mission_instance_id
      t.integer :current_event_id

      t.timestamps
    end
    
    add_index :user_missions, :user_id
    add_index :user_missions, :mission_instance_id
    add_index :user_missions, :current_event_id
  end
end
