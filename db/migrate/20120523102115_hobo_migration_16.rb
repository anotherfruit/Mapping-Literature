class HoboMigration16 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :shape, :string
  end

  def self.down
    remove_column :fragments, :shape
  end
end
