class RsFragmentTopic < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  attr_accessible

  belongs_to :topic, :inverse_of => :rs_fragment_topics
  belongs_to :fragment, :inverse_of => :rs_fragment_topics

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
