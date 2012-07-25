class Fragment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body                        :text
    page_nr_start               :integer
    page_nr_end                 :integer
#    lat                         :decimal, :precision => 15, :scale => 12
#    long                        :decimal, :precision => 15, :scale => 12
#    closest_matching_address    :string
    indoor                      :boolean
    outdoor                     :boolean
    immigrant                   :boolean
    surrogat                    :boolean
    non_replacable_scenery      :boolean
    geographic_horizon          :boolean
    setting                     :boolean
    fictional                   :boolean
    shape                       enum_string(:way, :space, :multipoint)
    timestamps
  end

  belongs_to :creation, :counter_cache => true
  belongs_to :user, :creator => true
  has_many :gpscoordsets, :accessible => :true
  children :gpscoordsets

#  acts_as_gmappable :lat => "lat", :lng => "long", :address =>"gmaps4rails_address", :checker => :prevent_geocoding

#  acts_as_list :scope => :creation

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

  def prevent_geocoding
    address.blank? || (!lat.blank? && !lng.blank?)
  end

end
