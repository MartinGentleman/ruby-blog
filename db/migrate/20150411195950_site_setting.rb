class SiteSetting < ActiveRecord::Migration
  def change
    add_column :settings, :site_id, :integer, references: :sites
    add_index "settings", ["site_id"], name: "index_setting_on_site_id"
  end
end
