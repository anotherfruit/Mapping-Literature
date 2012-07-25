class HoboMigration17 < ActiveRecord::Migration
  def self.up
    rename_column :fragments, :exchangable_scenery, :non_replacable_scenery
    add_column :fragments, :immigrant, :boolean
    add_column :fragments, :surrogat, :boolean
    add_column :fragments, :geographic_horizon, :boolean
    add_column :fragments, :setting, :boolean
    remove_column :fragments, :lat
    remove_column :fragments, :long
    remove_column :fragments, :closest_matching_address
  end

  def self.down
    rename_column :fragments, :non_replacable_scenery, :exchangable_scenery
    remove_column :fragments, :immigrant
    remove_column :fragments, :surrogat
    remove_column :fragments, :geographic_horizon
    remove_column :fragments, :setting
    add_column :fragments, :lat, :decimal
    add_column :fragments, :long, :decimal
    add_column :fragments, :closest_matching_address, :string
  end
end
