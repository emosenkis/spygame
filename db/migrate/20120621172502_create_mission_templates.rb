class CreateMissionTemplates < ActiveRecord::Migration
  def change
    create_table :mission_templates do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
