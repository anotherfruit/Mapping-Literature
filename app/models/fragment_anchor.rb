class FragmentAnchor < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end

  belongs_to :fragment, :accessible => true, :inverse_of => :fragment_anchors
  belongs_to :anchor, :accessible => true, :inverse_of => :fragment_anchors

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
