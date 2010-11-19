class AddDesignBackgroundColorToStores < ActiveRecord::Migration
  def self.up
    add_column :stores, :design_background_color, :string, :default => 'FFFFFF'
  end

  def self.down
    remove_column :stores, :design_background_color
  end
end
