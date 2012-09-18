
class Geometry < String

  COLUMN_TYPE = :spatial

  ::HoboFields.register_type("geometry", self)

  attr_accessor :rgeo

  def initialize(obj)
    if String === obj
      super(obj)
    else
      @rgeo = obj
      super(obj.to_s)
    end
  end

  def feature_collection_geojson
    RGeo::GeoJSON.encode(RGeo::GeoJSON::FeatureCollection.new([RGeo::GeoJSON::Feature.new(rgeo)]))
  end

end



