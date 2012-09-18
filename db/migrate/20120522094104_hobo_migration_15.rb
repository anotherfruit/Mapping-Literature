class HoboMigration15 < ActiveRecord::Migration
  def self.up
    remove_column :fragments, :gmaps4rails_address
  end

  def self.down
    add_column :fragments, :gmaps4rails_address, :string
  end
end
