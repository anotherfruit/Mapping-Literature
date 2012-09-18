class HoboMigration21 < ActiveRecord::Migration
  def self.up
    change_column :anchors, :name, :string, :limit => 255, :null => false, :default => nil
  end

  def self.down
    change_column :anchors, :name, :string, :default => "", :null => false
  end
end
