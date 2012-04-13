class Creation < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title              :string
    isbn10             :string
    isbn13             :string
    published_at       :date
    first_published_at :date
    timestamps
  end

  has_many :fragments, :dependent => :destroy
  has_many :rs_author_creations, :dependent => :destroy
  has_many :authors, :through => :rs_author_creations, :accessible => :true
  children :authors

  has_many :rs_creation_genres, :dependent => :destroy
  has_many :genres, :through => :rs_creation_genres, :accessible => :true
  children :genres

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
