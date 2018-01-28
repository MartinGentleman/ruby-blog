class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end
    
    add_index "settings", ["key"], name: "index_setting_on_key"
  end
end
