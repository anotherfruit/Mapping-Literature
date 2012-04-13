class Genre < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string
    hlink  :string
    timestamps
  end

  has_many :rs_creation_genres, :dependent => :destroy
  has_many :creations, :through => :rs_creation_genres, :accessible => :true
  children :creations



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
