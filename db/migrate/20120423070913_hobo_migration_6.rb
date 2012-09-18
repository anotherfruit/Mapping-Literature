class HoboMigration6 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :closest_matching_address, :string
  end

  def self.down
    remove_column :fragments, :closest_matching_address
  end
end
