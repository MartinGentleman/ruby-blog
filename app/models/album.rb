# create_table "albums", force: :cascade do |t|
#    t.string   "title"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#    t.integer  "site_id",    null: false
#  end
#
#  add_index "albums", ["site_id"], name: "index_album_on_site_id"
#  add_index "albums", ["title"], name: "index_album_on_title"

class Album < ActiveRecord::Base
  has_many :images, :dependent => :destroy
  belongs_to :site
  
  validates :title, presence: true,
                    length: { minimum: 3 },
                    uniqueness: true
  validates  :site_id, presence: true
  
  before_validation :input_cleaner
  
  def input_cleaner
    self.title = ActionController::Base.helpers.sanitize(self.title, tags: [])
  end
end
