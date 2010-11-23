class AddCafepressBackDesignIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cafepress_back_design_id, :string
  end

  def self.down
    remove_column :products, :cafepress_back_design_id
  end
end
