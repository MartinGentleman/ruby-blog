#  create_table "dynamic_menu_web_pages", force: :cascade do |t|
#    t.integer  "dynamic_menu_id"
#    t.integer  "web_page_id"
#    t.integer  "order",           null: false
#    t.datetime "created_at",      null: false
#    t.datetime "updated_at",      null: false
#  end
#
#  add_index "dynamic_menu_web_pages", ["dynamic_menu_id"], name: "index_dynamic_menu_web_pages_on_dynamic_menu_id"
#  add_index "dynamic_menu_web_pages", ["web_page_id"], name: "index_dynamic_menu_web_pages_on_web_page_id"

class DynamicMenuWebPage < ActiveRecord::Base
  belongs_to :web_page
  belongs_to :dynamic_menu
end