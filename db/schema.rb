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

ActiveRecord::Schema.define(version: 20161217022927) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counters", force: :cascade do |t|
    t.integer  "fork"
    t.integer  "stargazer"
    t.integer  "watcher"
    t.integer  "subscriber"
    t.integer  "open_issue"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_counters_on_package_id"
  end

  create_table "daters", force: :cascade do |t|
    t.datetime "created"
    t.datetime "updated"
    t.datetime "pushed"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_daters_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "repositories", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_repositories_on_package_id"
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "major"
    t.integer  "minor"
    t.integer  "patch"
    t.string   "sha1"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_versions_on_package_id"
  end

end
