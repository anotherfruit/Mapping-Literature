
class Geometry < String

  COLUMN_TYPE = :geometry

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

end



