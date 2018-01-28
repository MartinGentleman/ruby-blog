#  create_table "dynamic_menus", force: :cascade do |t|
#    t.string   "title"
#    t.integer  "site_id"
#    t.datetime "created_at", null: false
#    t.datetime "updated_at", null: false
#  end
#
#  add_index "dynamic_menus", ["site_id"], name: "index_dynamic_menus_on_site_id"
#  add_index "dynamic_menus", ["title"], name: "index_dynamic_menus_on_title"

class DynamicMenu < ActiveRecord::Base
  belongs_to :site
  has_many   :dynamic_menu_web_pages
  has_many   :web_pages, -> { order 'dynamic_menu_web_pages.order' }, :through => :dynamic_menu_web_pages
  validates  :title, presence: true,
                         length: { minimum: 3 }

  before_validation :input_cleaner
  
  def input_cleaner
    self.title = ActionController::Base.helpers.sanitize(self.title, tags: [])
  end
  
  def DynamicMenu.find_all_web_pages_by_dynamic_menu_title(title)
    menu = Site.current.dynamic_menus.find_by_title(title)
    if menu then
      return menu.web_pages.select('web_pages.id AS id, web_pages.title AS title, web_pages.path AS path')
    else
      return nil
    end
  end
  
  def DynamicMenu.replace(title, dynamic_menu_contents)
    dynamic_menu = Site.current.dynamic_menus.find_by_title(title)
    if !dynamic_menu then
      dynamic_menu = DynamicMenu.new
      dynamic_menu.title = title
      dynamic_menu.site_id = Site.current.id
      dynamic_menu.save!
    end
    self.transaction do
      DynamicMenuWebPage.destroy_all(dynamic_menu_id: dynamic_menu.id)
      i = 1
      dynamic_menu_contents.each do |id|
        menu = DynamicMenuWebPage.new
        menu.dynamic_menu_id = dynamic_menu.id
        menu.web_page_id = id
        menu.order = i
        menu.save!
        i = i+1
      end
    end
  end
end
