class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.integer :mission_id
      t.integer :user_id

      t.timestamps
    end
  end
end
