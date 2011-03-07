class CreateSizes < ActiveRecord::Migration
  def self.up
    create_table :sizes do |t|
      t.integer :product_id
      t.string :cafepress_size_id
      t.string :full_name
      t.string :display_sell_price

      t.timestamps
    end
  end

  def self.down
    drop_table :sizes
  end
end
