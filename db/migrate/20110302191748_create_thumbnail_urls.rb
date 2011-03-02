class CreateThumbnailUrls < ActiveRecord::Migration
  def self.up
    create_table :thumbnail_urls do |t|
      t.string :url
      t.string :color_id
      t.integer :product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :thumbnail_urls
  end
end
