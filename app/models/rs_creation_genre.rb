class RsCreationGenre < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :genre, :inverse_of => :rs_creation_genres
  belongs_to :creation, :inverse_of => :rs_creation_genres

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
