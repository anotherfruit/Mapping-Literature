class HoboMigration14 < ActiveRecord::Migration
  def self.up
    create_table :gpscoordsets do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.decimal  :lat, :precision => 15, :scale => 12
      t.decimal  :long, :precision => 15, :scale => 12
      t.integer  :fragment_id
    end
    add_index :gpscoordsets, [:fragment_id]
  end

  def self.down
    drop_table :gpscoordsets
  end
end
