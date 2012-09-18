class Anchor < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string, :null => false
    shape :geometry, :srid => 4326
    timestamps
  end
  set_rgeo_factory_for_column(:shape, RGeo::Cartesian::Factory.new(:srid => 4326))

  has_many :fragment_anchors, :inverse_of => :anchor
  has_many :fragments, :through => :fragment_anchors, :accessible => true

  def to_s
    name.blank? ? "anchor #{id}" : name
  end

  def self.labelled
    where("name <> ''")
  end

  def self.unlabelled
    where("name = ''")
  end

  # selects one of 5 closest anchors
  def near
    self.class.order_by("(select shape from anchors where id = #{id}) <-> shape").limit(1).offset((rand*5).to_i+1).first
  end

  def placemarks
    case shape._?.rgeo
    when RGeo::Feature::LineString
      [
       {
         polyline: shape.rgeo.points.map do |point|
           {lat: point.y, lon: point.x}
         end
       }
      ] + shape.rgeo.points.map do |point|
        {
          point: {
            lat: point.y,
            lon: point.x
          }
        }
      end
    when RGeo::Feature::MultiPoint
      shape.rgeo.map do |point|
        {
          point: {
            lat: point.y,
            lon: point.x
          }
        }
      end
    when RGeo::Feature::Polygon
      [ {
          polygon: shape.rgeo.exterior_ring.points.map do |point|
            {
              lat: point.y,
              lon: point.x
            }
          end
        } ]
    else
      Rails.logger.debug "unsupported shape for anchor #{id}"
      []
    end
  end

  def creations
    fragments.*.creation.sort.uniq
  end

  def shape_type
    shape.split(' ',2).first unless shape.nil?
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  # attr_accessible :title, :body
end
