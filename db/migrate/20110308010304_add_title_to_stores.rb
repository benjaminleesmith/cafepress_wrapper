class AddTitleToStores < ActiveRecord::Migration
  def self.up
    add_column :stores, :title, :string
  end

  def self.down
    remove_column :stores, :title
  end
end
