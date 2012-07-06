class CreateGameTemplates < ActiveRecord::Migration
  def change
    create_table :game_templates do |t|
      t.string :class_name
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
