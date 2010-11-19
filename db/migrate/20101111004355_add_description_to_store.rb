class AddDescriptionToStore < ActiveRecord::Migration
  def self.up
    add_column :stores, :description, :string
  end

  def self.down
    remove_column :stores, :description
  end
end
