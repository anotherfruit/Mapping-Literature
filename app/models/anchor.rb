class Anchor < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name  :string, :null => false
    shape :geometry, :geographic => true, :srid => 4326
    timestamps
  end
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geometry, RGeo::Geographic.spherical_factory(:srid => 4326))
  set_rgeo_factory_for_column(:shape, RGeo::Geographic.spherical_factory(:srid => 4326))

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
