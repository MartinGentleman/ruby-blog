class AddLanguageToWebPages < ActiveRecord::Migration
  def change
    add_column :web_pages, :language, :string, :null => false, :default => "en"
    add_index :web_pages, :language
  end
end
