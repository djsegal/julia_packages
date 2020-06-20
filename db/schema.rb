# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_18_214356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "labels_count"
    t.index ["labels_count"], name: "index_categories_on_labels_count"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "dependencies", force: :cascade do |t|
    t.bigint "depender_id", null: false
    t.bigint "dependee_id", null: false
    t.boolean "shallow"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dependee_id"], name: "index_dependencies_on_dependee_id"
    t.index ["depender_id"], name: "index_dependencies_on_depender_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "labels", force: :cascade do |t|
    t.bigint "package_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_labels_on_category_id"
    t.index ["package_id"], name: "index_labels_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "stars"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "updated"
    t.datetime "created"
    t.string "website"
    t.string "github_url"
    t.text "search"
    t.string "slug"
    t.boolean "registered"
    t.bigint "user_id", null: false
    t.index ["slug"], name: "index_packages_on_slug", unique: true
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "readmes", force: :cascade do |t|
    t.bigint "package_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_empty"
    t.text "html"
    t.index ["package_id"], name: "index_readmes_on_package_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "package_slug"
    t.string "category_slug"
    t.string "sub_category_slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "packages_count"
    t.string "slug"
    t.index ["packages_count"], name: "index_users_on_packages_count"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "dependencies", "packages", column: "dependee_id"
  add_foreign_key "dependencies", "packages", column: "depender_id"
  add_foreign_key "labels", "categories"
  add_foreign_key "labels", "packages"
  add_foreign_key "packages", "users"
  add_foreign_key "readmes", "packages"
end
