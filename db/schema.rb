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

ActiveRecord::Schema.define(version: 20160205015259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "event_roles", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "event_roles", ["name"], name: "index_event_roles_on_name", unique: true, using: :btree

  create_table "event_types", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "event_types", ["name"], name: "index_event_types_on_name", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "legacy_id"
    t.integer  "event_type_id"
    t.integer  "year"
    t.date     "date"
    t.geometry "lonlat",        limit: {:srid=>0, :type=>"point"}
    t.text     "description"
    t.string   "address"
  end

  add_index "events", ["date"], name: "index_events_on_date", using: :btree
  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["legacy_id"], name: "index_events_on_legacy_id", unique: true, using: :btree
  add_index "events", ["lonlat"], name: "index_events_on_lonlat", using: :gist
  add_index "events", ["year"], name: "index_events_on_year", using: :btree

  create_table "import_steps", force: :cascade do |t|
    t.string "step", null: false
  end

  add_index "import_steps", ["step"], name: "index_import_steps_on_step", unique: true, using: :btree

  create_table "landmarks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.geometry "lonlat",     limit: {:srid=>0, :type=>"point"}
    t.integer  "start_year"
  end

  add_index "landmarks", ["lonlat"], name: "index_landmarks_on_lonlat", using: :gist

  create_table "occupations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "occupations", ["name"], name: "index_occupations_on_name", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "family_name"
    t.string   "given_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "sex"
    t.integer  "birth_year"
    t.integer  "death_year"
    t.string   "legacy_id"
    t.boolean  "birth_est"
    t.boolean  "death_est"
  end

  add_index "people", ["legacy_id"], name: "index_people_on_legacy_id", unique: true, using: :btree

  create_table "person_event_rels", force: :cascade do |t|
    t.integer "person_id",     null: false
    t.integer "event_id",      null: false
    t.integer "event_role_id", null: false
  end

  add_index "person_event_rels", ["event_id", "person_id"], name: "index_person_event_rels_on_event_id_and_person_id", using: :btree
  add_index "person_event_rels", ["person_id", "event_id"], name: "index_person_event_rels_on_person_id_and_event_id", using: :btree

  create_table "person_occupation_rels", force: :cascade do |t|
    t.integer "occupation_id", null: false
    t.integer "person_id",     null: false
  end

  add_index "person_occupation_rels", ["occupation_id", "person_id"], name: "index_person_occupation_rels_on_occupation_id_and_person_id", using: :btree
  add_index "person_occupation_rels", ["person_id", "occupation_id"], name: "index_person_occupation_rels_on_person_id_and_occupation_id", using: :btree

  create_table "photographs", force: :cascade do |t|
    t.geometry "lonlat",          limit: {:srid=>0, :type=>"point"}
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "flickr_id",       limit: 8,                          null: false
    t.string   "url",                                                null: false
    t.string   "title"
    t.string   "address"
    t.integer  "license"
    t.boolean  "permission"
    t.string   "fee"
    t.string   "credit"
    t.integer  "accuracy"
    t.date     "permission_date"
  end

  add_index "photographs", ["flickr_id"], name: "index_photographs_on_flickr_id", unique: true, using: :btree
  add_index "photographs", ["lonlat"], name: "index_photographs_on_lonlat", using: :gist

  add_foreign_key "events", "event_types"
  add_foreign_key "person_event_rels", "events"
  add_foreign_key "person_event_rels", "people"
  add_foreign_key "person_occupation_rels", "occupations"
  add_foreign_key "person_occupation_rels", "people"
end
