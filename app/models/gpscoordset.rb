class Gpscoordset < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    lat                         :decimal, :precision => 15, :scale => 12
    long                        :decimal, :precision => 15, :scale => 12
  end

  belongs_to :fragment, :inverse_of => :gpscoordsets
  validates_presence_of :fragment

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
