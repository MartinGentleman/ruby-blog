# create_table "web_page_dynamic_menus", force: :cascade do |t|
#    t.string   "menu_name"
#    t.integer  "web_page_id"
#    t.datetime "created_at",  null: false
#    t.datetime "updated_at",  null: false
#  end
#
#  add_index "web_page_dynamic_menus", ["menu_name"], name: "index_web_page_dynamic_menus_on_menu_name"
#  add_index "web_page_dynamic_menus", ["web_page_id"], name: "index_web_page_dynamic_menus_on_web_page_id"

class WebPageDynamicMenu < ActiveRecord::Base
  belongs_to :web_page
  validates  :menu_name, presence: true,
                         length: { minimum: 3 }

  before_validation :input_cleaner
  
  def input_cleaner
    self.menu_name = ActionController::Base.helpers.sanitize(self.menu_name, tags: [])
  end
                         
  def WebPageDynamicMenu.replace(menu_name, dynamic_menu)
    self.transaction do
      WebPageDynamicMenu.destroy_all(menu_name: menu_name)
      dynamic_menu.each do |id|
        menu = WebPageDynamicMenu.new
        menu.menu_name = menu_name
        menu.web_page_id = id
        menu.save!
      end
    end
  end
  
  def WebPageDynamicMenu.find_all_by_menu_name_with_web_pages(menu_name)
    self.joins(:web_page)
        .select('web_pages.id AS id, web_pages.title AS title, web_pages.path AS path')
        .where(menu_name: menu_name)
  end
  
end
