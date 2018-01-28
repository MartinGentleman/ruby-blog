class CreateWebPageDynamicMenus < ActiveRecord::Migration
  def change
    create_table :web_page_dynamic_menus do |t|
      t.string :menu_name
      t.belongs_to :web_page, index: true

      t.timestamps null: false
    end
    add_index :web_page_dynamic_menus, :menu_name
  end
end
