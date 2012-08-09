
class Geometry < SimpleDelegator

  COLUMN_TYPE = :geometry

  ::HoboFields.register_type("geometry", self)

end



