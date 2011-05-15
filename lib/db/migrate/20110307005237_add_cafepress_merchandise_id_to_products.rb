class AddCafepressMerchandiseIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cafepress_merchandise_id, :string
  end

  def self.down
    remove_column :products, :cafepress_merchandise_id
  end
end
