class Creation < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title              :string, :required
    isbn10             :string
    isbn13             :string
    published_at       :date, :required
    first_published_at :date, :required
    publisher          :string
    publisher_url      :string
    fragments_count     :integer
    timestamps
  end

  validates_format_of :isbn10, :allow_blank => true, :with => /^(?:\d[\ |-]?){9}[\d|X]$/
  validates_format_of :isbn13, :allow_blank => true, :with => /^(?:\d[\ |-]?){13}$/

  has_many :fragments, :dependent => :destroy, :accessible => true
  has_many :rs_author_creations, :dependent => :destroy, :inverse_of => :creation
  has_many :authors, :through => :rs_author_creations, :accessible => :true

  has_many :rs_creation_genres, :dependent => :destroy, :inverse_of => :creation
  has_many :genres, :through => :rs_creation_genres, :accessible => :true

  children :fragments

  def anchors
    fragments.*.anchors.flatten
  end

  # returns one of the 5 creations closest by date to this one
  def near_to_date
    self.class.order_by("abs('#{first_published_at}' - first_published_at)").limit(1).offset((rand*5).to_i+1).first
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
