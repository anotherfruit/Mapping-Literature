class HoboMigration3 < ActiveRecord::Migration
  def self.up
    add_column :creations, :isbn10, :string
    remove_column :creations, :isbn9
  end

  def self.down
    remove_column :creations, :isbn10
    add_column :creations, :isbn9, :string
  end
end
