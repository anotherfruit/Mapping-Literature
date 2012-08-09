class HoboMigration20 < ActiveRecord::Migration
  def self.up
    create_table :anchors do |t|
      t.string   :name, :null => false, :default => ""
      t.geometry :shape, :geographic => true, :srid => 4326
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :fragment_anchors do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :fragment_id
      t.integer  :anchor_id
    end
    add_index :fragment_anchors, [:fragment_id]
    add_index :fragment_anchors, [:anchor_id]

    Fragment.find_each do |fragment|
      case fragment.shape
      when "multipoint"
        shape = "MULTIPOINT (#{fragment.gpscoordsets.map{|coord| coord.long.to_s+' '+coord.lat.to_s}.join(',')})"
      when "space"
        shape = "POLYGON ((#{fragment.gpscoordsets.map{|coord| coord.long.to_s+' '+coord.lat.to_s}.join(',')}))"
      when "way"
        shape = "LINESTRING (#{fragment.gpscoordsets.map{|coord| coord.long.to_s+' '+coord.lat.to_s}.join(',')})"
      else
        fail "fragment #{fragment.id} does not have a shape!"
      end
      a = fragment.anchors.create(:name => "", :shape => shape)
      puts "Failure: #{fragment.id}: #{shape}" if a.shape.blank?
    end
  end

  def self.down
    drop_table :anchors
    drop_table :fragment_anchors
  end
end
