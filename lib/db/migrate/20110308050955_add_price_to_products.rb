class AddPriceToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :price, :string
  end

  def self.down
    remove_column :products, :price
  end
end
