class AddImageSizeToImageUrls < ActiveRecord::Migration
  def self.up
    add_column :image_urls, :size, :string
  end

  def self.down
    remove_column :image_urls, :size
  end
end
