class AddGenderToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :gender, :string
  end

  def self.down
    remove_column :products, :gender
  end
end
