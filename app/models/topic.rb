class Topic < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title :string
    timestamps
  end
  attr_accessible :title

  has_many :rs_fragment_topics, :dependent => :destroy, :inverse_of => :topic
  has_many :fragments, :through => :rs_fragment_topics, :accessible => :true

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
