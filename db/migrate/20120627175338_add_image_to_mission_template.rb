class AddImageToMissionTemplate < ActiveRecord::Migration
  def change
    add_column :mission_templates, :image, :string
  end
end
