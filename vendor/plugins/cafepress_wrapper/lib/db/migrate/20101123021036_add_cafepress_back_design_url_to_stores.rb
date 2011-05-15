class AddCafepressBackDesignUrlToStores < ActiveRecord::Migration
  def self.up
    add_column :stores, :cafepress_back_design_url, :string
  end

  def self.down
    remove_column :stores, :cafepress_back_design_url
  end
end
