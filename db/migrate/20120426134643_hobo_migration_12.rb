class HoboMigration12 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :indoor, :boolean
    add_column :fragments, :outdoor, :boolean
    add_column :fragments, :exchangable_scenery, :boolean
    add_column :fragments, :fictional, :boolean
  end

  def self.down
    remove_column :fragments, :indoor
    remove_column :fragments, :outdoor
    remove_column :fragments, :exchangable_scenery
    remove_column :fragments, :fictional
  end
end
