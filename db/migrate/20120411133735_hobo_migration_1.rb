class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string   :first_name
      t.string   :middle_name
      t.string   :last_name
      t.date     :birthdate
      t.string   :hlink
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :creations do |t|
      t.string   :title
      t.string   :isbn9
      t.string   :isbn13
      t.date     :published_at
      t.date     :first_published_at
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :fragments do |t|
      t.text     :body
      t.integer  :page_nr_start
      t.integer  :page_nr_end
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :creation_id
    end
    add_index :fragments, [:creation_id]

    create_table :genres do |t|
      t.string   :title
      t.string   :hlink
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :rs_author_creations do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :creation_id
      t.integer  :author_id
    end
    add_index :rs_author_creations, [:creation_id]
    add_index :rs_author_creations, [:author_id]

    create_table :rs_creation_genres do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :authors
    drop_table :creations
    drop_table :fragments
    drop_table :genres
    drop_table :rs_author_creations
    drop_table :rs_creation_genres
  end
end
