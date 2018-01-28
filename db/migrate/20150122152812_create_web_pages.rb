class CreateWebPages < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.string :title
      t.text :content
      t.timestamp :published_at

      t.timestamps null: false
    end
  end
end
