class HoboMigration7 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :position, :integer
  end

  def self.down
    remove_column :fragments, :position
  end
end
