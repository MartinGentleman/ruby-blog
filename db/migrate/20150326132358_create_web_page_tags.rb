class CreateWebPageTags < ActiveRecord::Migration
  def change
    create_table :web_page_tags do |t|
      t.belongs_to :web_page, index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
