class AddImageToEventTemplate < ActiveRecord::Migration
  def change
  	add_column :event_templates, :image, :string
  end
end
