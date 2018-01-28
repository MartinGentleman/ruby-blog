#  create_table "sites", force: :cascade do |t|
#    t.string   "host",       null: false
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#  end
#
#  add_index "sites", ["host"], name: "index_site_on_host"

class Site < ActiveRecord::Base
  #@@current is define in application controller
  @@current = nil

  has_many   :settings,      :dependent => :destroy
  has_many   :albums,        :dependent => :destroy
  has_many   :web_pages,     :dependent => :destroy
  has_many   :dynamic_menus, :dependent => :destroy

  validates  :host, presence: true

  before_validation :input_cleaner
  
  def input_cleaner
    self.host = ActionController::Base.helpers.sanitize(self.host, tags: [])
  end
  
  def Site.set_current(current_host)
    @@current = Site.find_by_host(current_host) 
  end
  
  def Site.current
    return @@current
  end
end
