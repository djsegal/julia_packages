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

ActiveRecord::Schema.define(version: 20170405234312) do

  create_table "activities", force: :cascade do |t|
    t.text     "commits"
    t.integer  "package_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "recent_commit_count"
    t.index ["package_id"], name: "index_activities_on_package_id"
    t.index ["recent_commit_count"], name: "index_activities_on_recent_commit_count"
  end

  create_table "batches", force: :cascade do |t|
    t.integer  "marker"
    t.string   "item_type"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_batches_on_item_type_and_item_id"
    t.index ["marker"], name: "index_batches_on_marker"
  end

  create_table "blurbs", force: :cascade do |t|
    t.text     "cargo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contributions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "score"
    t.index ["package_id"], name: "index_contributions_on_package_id"
    t.index ["user_id", "package_id"], name: "index_contributions_on_uniqueness", unique: true
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "counters", force: :cascade do |t|
    t.integer  "fork"
    t.integer  "stargazer"
    t.integer  "open_issue"
    t.integer  "package_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "contributor"
    t.index ["package_id"], name: "index_counters_on_package_id"
  end

  create_table "daters", force: :cascade do |t|
    t.datetime "created"
    t.datetime "updated"
    t.datetime "pushed"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "touched"
    t.index ["package_id"], name: "index_daters_on_package_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "downloads", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dummies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "infos", force: :cascade do |t|
    t.integer  "repos"
    t.integer  "followers"
    t.integer  "following"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "gists"
    t.index ["owner_type", "owner_id"], name: "index_infos_on_owner_type_and_owner_id"
  end

  create_table "labels", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "package_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id", "package_id"], name: "index_labels_on_uniqueness", unique: true
    t.index ["category_id"], name: "index_labels_on_category_id"
    t.index ["package_id"], name: "index_labels_on_package_id"
  end

  create_table "news_items", force: :cascade do |t|
    t.string   "name"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "type"
    t.integer  "position"
    t.index ["position"], name: "index_news_items_on_position"
    t.index ["target_type", "target_id"], name: "index_news_items_on_target_type_and_target_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "description"
    t.string   "homepage"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.boolean  "is_registered"
    t.index ["is_registered"], name: "index_packages_on_is_registered"
    t.index ["name"], name: "index_packages_on_name"
    t.index ["owner_type", "owner_id"], name: "index_packages_on_owner_type_and_owner_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "nickname"
    t.string   "company"
    t.string   "blog"
    t.string   "location"
    t.string   "bio"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "created"
    t.index ["owner_type", "owner_id"], name: "index_profiles_on_owner_type_and_owner_id"
  end

  create_table "readmes", force: :cascade do |t|
    t.string   "file_name"
    t.text     "cargo"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_readmes_on_package_id"
  end

  create_table "references", force: :cascade do |t|
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "releases", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["published_at"], name: "index_releases_on_published_at"
  end

  create_table "repositories", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_repositories_on_package_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "feed_id"
    t.integer  "news_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["feed_id"], name: "index_subscriptions_on_feed_id"
    t.index ["news_item_id"], name: "index_subscriptions_on_news_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avatar"
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
