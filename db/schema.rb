# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120705155727) do

  create_table "game_states", :force => true do |t|
    t.datetime "date_time_of_start"
    t.integer  "game_template_id"
    t.text     "state"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "game_states", ["date_time_of_start"], :name => "index_game_states_on_date_time_of_start"
  add_index "game_states", ["game_template_id"], :name => "index_game_states_on_game_template_id"

  create_table "game_templates", :force => true do |t|
    t.string   "class_name"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "players", :force => true do |t|
    t.integer  "game_state_id"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "role"
    t.text     "state"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "players", ["game_state_id"], :name => "index_players_on_game_state_id"
  add_index "players", ["user_id"], :name => "index_players_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
