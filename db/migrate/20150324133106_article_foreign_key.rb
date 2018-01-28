class ArticleForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :web_pages, :images
  end
end
