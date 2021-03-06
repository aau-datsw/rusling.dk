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

ActiveRecord::Schema.define(version: 2019_08_26_161503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accordion_items", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["page_id"], name: "index_accordion_items_on_page_id"
    t.index ["position"], name: "index_accordion_items_on_position"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "campuses", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_campuses_on_name"
    t.index ["university"], name: "index_campuses_on_university"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "email"
    t.string "description"
    t.string "image"
    t.bigint "educational_domain_id"
    t.index ["educational_domain_id"], name: "index_contacts_on_educational_domain_id"
  end

  create_table "domain_images", force: :cascade do |t|
    t.string "name"
    t.bigint "educational_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["educational_domain_id"], name: "index_domain_images_on_educational_domain_id"
  end

  create_table "educational_domains", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "default_page_id"
    t.integer "primary_menu_id"
    t.integer "secondary_menu_id"
    t.jsonb "colors", default: []
    t.text "educations", default: [], array: true
    t.string "locale"
    t.bigint "campus_id"
    t.index ["campus_id"], name: "index_educational_domains_on_campus_id"
    t.index ["default_page_id"], name: "index_educational_domains_on_default_page_id"
    t.index ["domain"], name: "index_educational_domains_on_domain"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.bigint "educational_domain_id"
    t.string "description"
    t.string "location"
    t.decimal "lat", precision: 9, scale: 6
    t.decimal "lng", precision: 9, scale: 6
    t.datetime "begin_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_at"
    t.index ["educational_domain_id"], name: "index_events_on_educational_domain_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "link"
    t.string "name"
    t.string "image_url"
    t.string "description"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.jsonb "colors"
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["position"], name: "index_menu_items_on_position"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.jsonb "items"
    t.bigint "educational_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["educational_domain_id"], name: "index_menus_on_educational_domain_id"
  end

  create_table "oauth_logins", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "secret"
    t.datetime "expires_at"
    t.jsonb "raw_data"
    t.bigint "user_id"
    t.index ["expires_at"], name: "index_oauth_logins_on_expires_at"
    t.index ["provider"], name: "index_oauth_logins_on_provider"
    t.index ["token"], name: "index_oauth_logins_on_token"
    t.index ["uid"], name: "index_oauth_logins_on_uid"
    t.index ["user_id"], name: "index_oauth_logins_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "slug"
    t.string "title"
    t.text "content"
    t.bigint "educational_domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "view_file"
    t.jsonb "accordion"
    t.string "content_header"
    t.index ["educational_domain_id"], name: "index_pages_on_educational_domain_id"
    t.index ["slug"], name: "index_pages_on_slug"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "educational_domain_id"
    t.index ["educational_domain_id"], name: "index_sponsors_on_educational_domain_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "educational_domain_id"
    t.boolean "domain_admin", default: false
    t.boolean "system_admin", default: false
    t.index ["educational_domain_id"], name: "index_users_on_educational_domain_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["password_digest"], name: "index_users_on_password_digest"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contacts", "educational_domains"
  add_foreign_key "domain_images", "educational_domains"
  add_foreign_key "educational_domains", "campuses"
  add_foreign_key "educational_domains", "menus", column: "primary_menu_id", on_delete: :nullify
  add_foreign_key "educational_domains", "menus", column: "secondary_menu_id", on_delete: :nullify
  add_foreign_key "events", "educational_domains"
  add_foreign_key "menus", "educational_domains"
  add_foreign_key "sponsors", "educational_domains"
  add_foreign_key "users", "educational_domains"
end
