class ChangeUserTitleToName < ActiveRecord::Migration
  def up
  	rename_column :users, :title, :name
  end

  def down
  	 rename_column :users, :name, :title
  end
end
