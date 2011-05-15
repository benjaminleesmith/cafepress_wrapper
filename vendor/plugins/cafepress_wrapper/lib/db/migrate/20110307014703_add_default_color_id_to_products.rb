class AddDefaultColorIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :default_color_id, :string
  end

  def self.down
    remove_column :products, :default_color_id
  end
end
