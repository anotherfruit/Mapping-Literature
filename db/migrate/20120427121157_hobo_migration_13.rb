class HoboMigration13 < ActiveRecord::Migration
  def self.up
    rename_column :creations, :fragment_count, :fragments_count
  end

  def self.down
    rename_column :creations, :fragments_count, :fragment_count
  end
end
