class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :host,         null: false

      t.timestamps null: false
    end
    
    add_index "sites", ["host"], name: "index_site_on_host"
  end
end
