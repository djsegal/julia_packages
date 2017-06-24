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

ActiveRecord::Schema.define(version: 20170624212901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "activities", force: :cascade do |t|
    t.text     "commits"
    t.integer  "package_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "recent_commit_count"
    t.index ["package_id"], name: "index_activities_on_package_id", using: :btree
    t.index ["recent_commit_count"], name: "index_activities_on_recent_commit_count", using: :btree
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.jsonb    "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time", using: :btree
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name", using: :btree
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name", using: :btree
  end

  create_table "batches", force: :cascade do |t|
    t.integer  "marker"
    t.string   "item_type"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type", "item_id"], name: "index_batches_on_item_type_and_item_id", using: :btree
    t.index ["marker"], name: "index_batches_on_marker", using: :btree
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
    t.index ["package_id"], name: "index_contributions_on_package_id", using: :btree
    t.index ["user_id", "package_id"], name: "index_contributions_on_uniqueness", unique: true, using: :btree
    t.index ["user_id"], name: "index_contributions_on_user_id", using: :btree
  end

  create_table "counters", force: :cascade do |t|
    t.integer  "fork"
    t.integer  "stargazer"
    t.integer  "open_issue"
    t.integer  "package_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "contributor"
    t.index ["package_id"], name: "index_counters_on_package_id", using: :btree
  end

  create_table "daters", force: :cascade do |t|
    t.datetime "created"
    t.datetime "updated"
    t.datetime "pushed"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "touched"
    t.index ["package_id"], name: "index_daters_on_package_id", using: :btree
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "dependencies", force: :cascade do |t|
    t.integer  "dependent_id"
    t.integer  "depended_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_shallow"
    t.index ["depended_id"], name: "index_dependencies_on_depended_id", using: :btree
    t.index ["dependent_id", "depended_id"], name: "index_dependencies_on_uniqueness", unique: true, using: :btree
    t.index ["dependent_id"], name: "index_dependencies_on_dependent_id", using: :btree
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
    t.index ["owner_type", "owner_id"], name: "index_infos_on_owner_type_and_owner_id", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "package_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id", "package_id"], name: "index_labels_on_uniqueness", unique: true, using: :btree
    t.index ["category_id"], name: "index_labels_on_category_id", using: :btree
    t.index ["package_id"], name: "index_labels_on_package_id", using: :btree
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
    t.index ["position"], name: "index_news_items_on_position", using: :btree
    t.index ["target_type", "target_id"], name: "index_news_items_on_target_type_and_target_id", using: :btree
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
    t.text     "readme"
    t.string   "readme_type"
    t.index ["is_registered"], name: "index_packages_on_is_registered", using: :btree
    t.index ["name"], name: "index_packages_on_name", using: :btree
    t.index ["owner_type", "owner_id"], name: "index_packages_on_owner_type_and_owner_id", using: :btree
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
    t.index ["owner_type", "owner_id"], name: "index_profiles_on_owner_type_and_owner_id", using: :btree
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
    t.index ["published_at"], name: "index_releases_on_published_at", using: :btree
  end

  create_table "repositories", force: :cascade do |t|
    t.integer  "package_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_repositories_on_package_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "feed_id"
    t.integer  "news_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["feed_id"], name: "index_subscriptions_on_feed_id", using: :btree
    t.index ["news_item_id"], name: "index_subscriptions_on_news_item_id", using: :btree
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
    t.index ["package_id"], name: "index_versions_on_package_id", using: :btree
  end

  create_table "visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.string   "ip"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.integer  "screen_height"
    t.integer  "screen_width"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "postal_code"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_visits_on_user_id", using: :btree
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "packages"
  add_foreign_key "contributions", "packages"
  add_foreign_key "contributions", "users"
  add_foreign_key "counters", "packages"
  add_foreign_key "daters", "packages"
  add_foreign_key "labels", "categories"
  add_foreign_key "labels", "packages"
  add_foreign_key "repositories", "packages"
  add_foreign_key "subscriptions", "feeds"
  add_foreign_key "subscriptions", "news_items"
  add_foreign_key "versions", "packages"
end
