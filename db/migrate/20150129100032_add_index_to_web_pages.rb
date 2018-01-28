class AddIndexToWebPages < ActiveRecord::Migration
  def change
    #add_column :web_pages, :path, :string
    add_index :web_pages, :path, unique: true
    #add_column :web_pages, :title, :string
    add_index :web_pages, :title, unique: true
  end
end
