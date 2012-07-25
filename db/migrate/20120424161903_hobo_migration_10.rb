class HoboMigration10 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :gmaps4rails_address, :string
  end

  def self.down
    remove_column :fragments, :gmaps4rails_address
  end
end
