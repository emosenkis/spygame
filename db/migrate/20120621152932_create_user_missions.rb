class CreateUserMissions < ActiveRecord::Migration
  def change
    create_table :user_missions do |t|

      t.timestamps
    end
  end
end
