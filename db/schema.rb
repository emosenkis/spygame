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

ActiveRecord::Schema.define(:version => 20120627175338) do

  create_table "event_instances", :force => true do |t|
    t.integer  "event_template_id"
    t.integer  "user_id"
    t.integer  "mission_instance_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "event_instances", ["event_template_id"], :name => "index_event_instances_on_event_template_id"
  add_index "event_instances", ["mission_instance_id"], :name => "index_event_instances_on_mission_instance_id"
  add_index "event_instances", ["user_id"], :name => "index_event_instances_on_user_id"

  create_table "event_templates", :force => true do |t|
    t.integer  "mission_template_id"
    t.string   "title"
    t.text     "description"
    t.integer  "parent_event_id"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "radius"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "event_templates", ["mission_template_id"], :name => "index_event_templates_on_mission_template_id"
  add_index "event_templates", ["parent_event_id"], :name => "index_event_templates_on_parent_event_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "mission_instances", :force => true do |t|
    t.integer  "mission_template_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "mission_instances", ["mission_template_id"], :name => "index_mission_instances_on_mission_template_id"

  create_table "mission_templates", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "image"
  end

  create_table "user_missions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "mission_instance_id"
    t.integer  "current_event_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "user_missions", ["current_event_id"], :name => "index_user_missions_on_current_event_id"
  add_index "user_missions", ["mission_instance_id"], :name => "index_user_missions_on_mission_instance_id"
  add_index "user_missions", ["user_id"], :name => "index_user_missions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "title"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
