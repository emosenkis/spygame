class CreateEventTemplates < ActiveRecord::Migration
  def change
    create_table :event_templates do |t|
      t.integer :mission_template_id
      t.string :title
      t.text :description
      t.integer :parent_event_id
      t.float :latitude
      t.float :longitude
      t.float :radius

      t.timestamps
    end
    add_index :event_templates, :mission_template_id
    add_index :event_templates, :parent_event_id
  end
end
