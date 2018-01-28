class DropMercuryImagesTable < ActiveRecord::Migration
  def up
    drop_table :mercury_images
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
