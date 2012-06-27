class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_template_id
      t.integer :mission_id
      t.integer :user_id

      t.timestamps
    end
  end
end
