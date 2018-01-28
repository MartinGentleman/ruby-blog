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

ActiveRecord::Schema.define(version: 20151029185139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "site_id"
  end

  add_index "albums", ["site_id"], name: "index_album_on_site_id", using: :btree
  add_index "albums", ["title"], name: "index_album_on_title", using: :btree

  create_table "dynamic_menu_web_pages", force: :cascade do |t|
    t.integer  "dynamic_menu_id"
    t.integer  "web_page_id"
    t.integer  "order",           null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "dynamic_menu_web_pages", ["dynamic_menu_id"], name: "index_dynamic_menu_web_pages_on_dynamic_menu_id", using: :btree
  add_index "dynamic_menu_web_pages", ["web_page_id"], name: "index_dynamic_menu_web_pages_on_web_page_id", using: :btree

  create_table "dynamic_menus", force: :cascade do |t|
    t.string   "title"
    t.integer  "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dynamic_menus", ["site_id"], name: "index_dynamic_menus_on_site_id", using: :btree
  add_index "dynamic_menus", ["title"], name: "index_dynamic_menus_on_title", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "album_id"
  end

  add_index "images", ["album_id"], name: "index_images_on_album_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "site_id"
  end

  add_index "settings", ["key"], name: "index_setting_on_key", using: :btree
  add_index "settings", ["site_id"], name: "index_setting_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "host",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sites", ["host"], name: "index_site_on_host", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "web_page_dynamic_menus", force: :cascade do |t|
    t.string   "menu_name"
    t.integer  "web_page_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "web_page_dynamic_menus", ["menu_name"], name: "index_web_page_dynamic_menus_on_menu_name", using: :btree
  add_index "web_page_dynamic_menus", ["web_page_id"], name: "index_web_page_dynamic_menus_on_web_page_id", using: :btree

  create_table "web_page_tags", force: :cascade do |t|
    t.integer  "web_page_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "web_page_tags", ["tag_id"], name: "index_web_page_tags_on_tag_id", using: :btree
  add_index "web_page_tags", ["web_page_id"], name: "index_web_page_tags_on_web_page_id", using: :btree

  create_table "web_pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "path"
    t.integer  "image_id"
    t.text     "summary"
    t.string   "language",     default: "en", null: false
    t.integer  "site_id"
  end

  add_index "web_pages", ["image_id"], name: "index_web_pages_on_image_id", using: :btree
  add_index "web_pages", ["language"], name: "index_web_pages_on_language", using: :btree
  add_index "web_pages", ["path"], name: "index_web_pages_on_path", unique: true, using: :btree
  add_index "web_pages", ["site_id"], name: "index_web_page_on_site_id", using: :btree
  add_index "web_pages", ["title"], name: "index_web_pages_on_title", unique: true, using: :btree

end
