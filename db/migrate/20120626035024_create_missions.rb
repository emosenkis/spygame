class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :title
      t.string :description
      t.integer :mission_id

      t.timestamps
    end
  end
end
