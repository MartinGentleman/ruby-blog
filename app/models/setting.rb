#  create_table "settings", force: :cascade do |t|
#    t.string   "key",        null: false
#    t.string   "value",      null: false
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#    t.integer  "site_id"
#  end
#
#  add_index "settings", ["key"], name: "index_setting_on_key"
#  add_index "settings", ["site_id"], name: "index_setting_on_site_id"

class Setting < ActiveRecord::Base
  belongs_to :site
  validates  :key,   presence: true,
                     length: { minimum: 3 }
  validates  :value, presence: true,
                     length: { minimum: 3 }
  validates  :site_id, presence: true

  before_validation :input_cleaner
  
  def input_cleaner
    self.key = ActionController::Base.helpers.sanitize(self.key, tags: [])
    self.value = ActionController::Base.helpers.sanitize(self.value, tags: [])
  end
  
  scope :key, ->(setting_key) { limit(1).find_by_key(setting_key) }
end
