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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141011080531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "costs", force: true do |t|
    t.integer  "trip_id"
    t.string   "title",                       null: false
    t.text     "notes"
    t.float    "estimate"
    t.integer  "quantity"
    t.float    "final_total"
    t.integer  "priority"
    t.boolean  "paid",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costs", ["id"], name: "index_costs_on_id", using: :btree
  add_index "costs", ["trip_id"], name: "index_costs_on_trip_id", using: :btree

  create_table "destinations", force: true do |t|
    t.integer  "trip_id"
    t.string   "title",      null: false
    t.text     "options"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinations", ["id"], name: "index_destinations_on_id", using: :btree
  add_index "destinations", ["trip_id"], name: "index_destinations_on_trip_id", using: :btree

  create_table "task_lists", force: true do |t|
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "task_lists", ["owner_id"], name: "index_task_lists_on_owner_id", using: :btree

  create_table "tasks", force: true do |t|
    t.string   "description",                 null: false
    t.integer  "priority"
    t.date     "due_date"
    t.boolean  "completed",   default: false, null: false
    t.integer  "list_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.integer  "owner_id"
    t.string   "title",      null: false
    t.date     "begin_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trips", ["owner_id"], name: "index_trips_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
