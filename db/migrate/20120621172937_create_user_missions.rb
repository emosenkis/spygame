class CreateUserMissions < ActiveRecord::Migration
  def change
    create_table :user_missions do |t|
      t.integer :user_id
      t.integer :mission_instance_id
      t.integer :current_event_id

      t.timestamps
    end
  end
end
