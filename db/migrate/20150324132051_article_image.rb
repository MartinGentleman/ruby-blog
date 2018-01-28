class ArticleImage < ActiveRecord::Migration
  def change
    add_column :web_pages, :image_id, :integer, references: :images
  end
end
