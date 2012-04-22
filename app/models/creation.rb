class Creation < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title              :string, :required
    isbn10             :string
    isbn13             :string
    published_at       :date, :required
    first_published_at :date, :required
    timestamps
  end

  validates_format_of :isbn10, :allow_blank => true, :with => /^(?:\d[\ |-]?){9}[\d|X]$/
  validates_format_of :isbn13, :allow_blank => true, :with => /^(?:\d[\ |-]?){13}$/

  has_many :fragments, :dependent => :destroy, :inverse_of => :creation
  has_many :rs_author_creations, :dependent => :destroy, :inverse_of => :creation
  has_many :authors, :through => :rs_author_creations, :accessible => :true

  has_many :rs_creation_genres, :dependent => :destroy, :inverse_of => :creation
  has_many :genres, :through => :rs_creation_genres, :accessible => :true

  children :genres, :fragments



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
