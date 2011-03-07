class AddDefaultCafepressSizeIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :default_cafepress_size_id, :string
  end

  def self.down
    remove_column :products, :default_cafepress_size_id
  end
end
