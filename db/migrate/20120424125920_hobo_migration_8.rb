class HoboMigration8 < ActiveRecord::Migration
  def self.up
    remove_column :fragments, :position
  end

  def self.down
    add_column :fragments, :position, :integer
  end
end
