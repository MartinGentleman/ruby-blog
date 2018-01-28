class AddOrderToDynamicMenuWebPages < ActiveRecord::Migration
  def change
    add_column :dynamic_menu_web_pages, :order, :integer
  end
end
