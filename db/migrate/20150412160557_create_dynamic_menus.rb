class CreateDynamicMenus < ActiveRecord::Migration
  def change
    create_table :dynamic_menus do |t|
      t.string :title
      t.belongs_to :site, index: true

      t.timestamps null: false
    end
    
    create_table :dynamic_menu_web_pages do |t|
      t.belongs_to :dynamic_menu, index: true
      t.belongs_to :web_page, index: true
      
      t.timestamps null: false
    end
  end
end
