#  create_table "tags", force: :cascade do |t|
#    t.string   "name"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#  end
#
#  add_index "tags", ["name"], name: "index_tags_on_name", unique: true
  
class Tag < ActiveRecord::Base
  has_many    :web_page_tags, :dependent => :destroy
  has_many    :web_pages, :through => :web_page_tags
  validates   :name, presence: true,
                     length: { minimum: 2 },
                     uniqueness: true

  before_validation :input_cleaner
  
  def input_cleaner
    self.name = ActionController::Base.helpers.sanitize(self.name, tags: [])
  end
end
