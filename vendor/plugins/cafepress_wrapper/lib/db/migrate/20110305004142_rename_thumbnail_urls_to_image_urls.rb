class RenameThumbnailUrlsToImageUrls < ActiveRecord::Migration
  def self.up
    rename_table :thumbnail_urls, :image_urls
  end

  def self.down
    rename_table :image_urls, :thumbnail_urls
  end
end
