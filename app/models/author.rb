class Author < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    first_name  :string
    middle_name :string
    last_name   :string
    birthdate   :date
    hlink        :string
    timestamps
  end

  has_many :rs_author_creations, :dependent => :destroy, :inverse_of => :author
  has_many :creations, :through => :rs_author_creations, :accessible => :true
  #children :creations

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
