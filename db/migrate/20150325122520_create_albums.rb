class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title

      t.timestamps null: false
    end
    add_reference :images, :album, index: true
  end
end
