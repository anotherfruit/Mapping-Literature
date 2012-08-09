class Anchor < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name     :string
    shape :geometry, :geographic => true, :srid => 4326
    timestamps
  end
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geometry, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:shape, RGeo::Geographic.spherical_factory(:srid => 4326))

  has_many :fragment_anchors, :inverse_of => :anchor
  has_many :fragments, :through => :fragment_anchors

def shape;
  @attributes_cache['shape'] ||= begin;
                                      val = begin;
                                              missing_attribute('shape', caller) unless @attributes.has_key?('shape');
                                              cast_code = self.class.columns_hash["shape"].type_cast_code('v')
                                              Rails.logger.debug cast_code
                                              (v=@attributes['shape']) && eval(cast_code);
                                            end;
                                      wrapper_type = self.class.attr_type(:shape);
                                      Rails.logger.debug wrapper_type
                                      if HoboFields.can_wrap?(wrapper_type, val);
                                        wrapper_type.new(val);
                                      else;
                                        val;
                                      end;
                                    end;;
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
