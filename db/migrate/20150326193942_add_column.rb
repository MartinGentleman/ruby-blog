class AddColumn < ActiveRecord::Migration
  def change
    add_column :web_pages, :summary, :text
  end
end
