class HoboMigration11 < ActiveRecord::Migration
  def self.up
    add_column :creations, :fragment_count, :integer

    remove_column :fragments, :position
  end

  def self.down
    remove_column :creations, :fragment_count

    add_column :fragments, :position, :integer
  end
end
