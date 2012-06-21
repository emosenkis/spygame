class CreateEventTemplates < ActiveRecord::Migration
  def change
    create_table :event_templates do |t|
      t.string :title
      t.text :description
      t.integer :parent_event
      t.float :latitude
      t.float :longitude
      t.integer :radius

      t.timestamps
    end
  end
end
