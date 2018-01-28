class AddPathToWebPages < ActiveRecord::Migration
  def change
    add_column :web_pages, :path, :string
  end
end
