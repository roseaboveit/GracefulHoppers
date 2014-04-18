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

ActiveRecord::Schema.define(version: 20140418193719) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lessons", force: true do |t|
    t.integer  "unit_id"
    t.text     "description"
    t.string   "path"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "lessons", ["unit_id"], name: "index_lessons_on_unit_id", using: :btree

  create_table "segments", force: true do |t|
    t.integer  "lesson_id"
    t.string   "content_type"
    t.text     "content"
    t.integer  "place_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segments", ["lesson_id"], name: "index_segments_on_lesson_id", using: :btree

  create_table "units", force: true do |t|
    t.boolean  "published"
    t.text     "description"
    t.integer  "total_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.boolean  "admin"
    t.integer  "unit"
    t.text     "description"
    t.string   "twitter_uid"
    t.string   "github_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
