#create_table "web_page_tags", force: :cascade do |t|
#    t.integer  "web_page_id"
#    t.integer  "tag_id"
#    t.datetime "created_at",  null: false
#    t.datetime "updated_at",  null: false
#  end
#
#  add_index "web_page_tags", ["tag_id"], name: "index_web_page_tags_on_tag_id"
#  add_index "web_page_tags", ["web_page_id"], name: "index_web_page_tags_on_web_page_id"

class WebPageTag < ActiveRecord::Base
  belongs_to :web_page
  belongs_to :tag
end
