class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :default_caption
      t.string :url
      t.integer :store_id
      t.string :cafepress_product_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
