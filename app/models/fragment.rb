class Fragment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body                        :text
    page_nr_start               :integer
    page_nr_end                 :integer
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

  belongs_to :creation, :counter_cache => true, :inverse_of => :fragments
  belongs_to :user, :creator => true
  has_many :fragment_anchors, :inverse_of => :fragment
  has_many :anchors, :through => :fragment_anchors, :accessible => :true
  children :anchors

  has_many :rs_fragment_topics, :dependent => :destroy, :inverse_of => :fragment
  has_many :topics, :through => :rs_fragment_topics, :accessible => :true

  # temporary, will be removed once transition to anchors is complete
  has_many :gpscoordsets, :accessible => :true, :inverse_of => :fragment


  default_scope order("page_nr_start ASC")

  #  acts_as_list :scope => :creation

  def placemarks
    case shape
    when "way"
      [
       {
         polyline: gpscoordsets.map do |gpscoordset|
           {lat: gpscoordset.lat, lon: gpscoordset.long}
         end
       }
      ] + gpscoordsets.map do |gpscoordset|
        {
          point: {
            lat: gpscoordset.lat,
            lon: gpscoordset.long
          }
        }
      end
    when "multipoint"
      gpscoordsets.map do |gpscoordset|
        {
          point: {
            lat: gpscoordset.lat,
            lon: gpscoordset.long
          }
        }
      end
    when "space"
      [ {
          polygon: gpscoordsets.map do |gpscoordset|
            {
              lat: gpscoordset.lat,
              lon: gpscoordset.long
            }
          end
        } ]
    else
      []
    end
  end

  def page_range
    page_nr_start==page_nr_end ? page_nr_start.to_s : "#{page_nr_start}-#{page_nr_end}"
  end

  def name
    "#{creation.title} pp #{page_range}"
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

end
