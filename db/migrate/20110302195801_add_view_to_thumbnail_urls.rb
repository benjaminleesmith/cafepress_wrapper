class AddViewToThumbnailUrls < ActiveRecord::Migration
  def self.up
    add_column :thumbnail_urls, :view, :string
  end

  def self.down
    remove_column :thumbnail_urls, :view
  end
end
