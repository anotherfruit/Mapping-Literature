class HoboMigration19 < ActiveRecord::Migration
  def self.up
    add_column :creations, :publisher, :string
    add_column :creations, :publisher_url, :string
  end

  def self.down
    remove_column :creations, :publisher
    remove_column :creations, :publisher_url
  end
end
