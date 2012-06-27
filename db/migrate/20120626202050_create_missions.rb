class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.integer :mission_template_id

      t.timestamps
    end
    add_index :missions, :mission_template_id
  end
end
