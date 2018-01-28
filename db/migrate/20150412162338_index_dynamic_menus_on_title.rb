class IndexDynamicMenusOnTitle < ActiveRecord::Migration
  def change
    add_index "dynamic_menus", ["title"], name: "index_dynamic_menus_on_title"
  end
end
