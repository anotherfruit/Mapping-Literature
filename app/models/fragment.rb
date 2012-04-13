class Fragment < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    body          :text
    page_nr_start :integer
    page_nr_end   :integer
    timestamps
  end

  belongs_to :creation

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
