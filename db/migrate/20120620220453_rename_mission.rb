class RenameMission < ActiveRecord::Migration
  def up
  	rename_table :missions, :mission_templates
  end

  def down
  		rename_table :mission_templates, :missions
  end
end
