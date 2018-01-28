class AddSiteEverywhere < ActiveRecord::Migration
  def change
    add_column :web_pages, :site_id, :integer, references: :sites
    add_column :albums, :site_id, :integer, references: :sites
    add_index "web_pages", ["site_id"], name: "index_web_page_on_site_id"
    add_index "albums", ["site_id"], name: "index_album_on_site_id"
  end
end
