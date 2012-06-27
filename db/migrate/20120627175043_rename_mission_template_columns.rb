class RenameMissionTemplateColumns < ActiveRecord::Migration
  def up
  	rename_column :mission_templates, :name, :title
  end

  def down
  	rename_column :mission_templates, :title, :name
  end
end
