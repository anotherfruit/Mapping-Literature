class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :lat, :decimal, :precision => 15, :scale => 12
    add_column :fragments, :long, :decimal, :precision => 15, :scale => 12
  end

  def self.down
    remove_column :fragments, :lat
    remove_column :fragments, :long
  end
end
