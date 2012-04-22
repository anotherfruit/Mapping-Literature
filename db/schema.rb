# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120417173438) do

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "hlink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creations", :force => true do |t|
    t.string   "title"
    t.string   "isbn13"
    t.date     "published_at"
    t.date     "first_published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "isbn10"
  end

  create_table "fragments", :force => true do |t|
    t.text     "body"
    t.integer  "page_nr_start"
    t.integer  "page_nr_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creation_id"
    t.decimal  "lat",           :precision => 15, :scale => 12
    t.decimal  "long",          :precision => 15, :scale => 12
  end

  add_index "fragments", ["creation_id"], :name => "index_fragments_on_creation_id"

  create_table "genres", :force => true do |t|
    t.string   "title"
    t.string   "hlink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rs_author_creations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creation_id"
    t.integer  "author_id"
  end

  add_index "rs_author_creations", ["author_id"], :name => "index_rs_author_creations_on_author_id"
  add_index "rs_author_creations", ["creation_id"], :name => "index_rs_author_creations_on_creation_id"

  create_table "rs_creation_genres", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "genre_id"
    t.integer  "creation_id"
  end

  add_index "rs_creation_genres", ["creation_id"], :name => "index_rs_creation_genres_on_creation_id"
  add_index "rs_creation_genres", ["genre_id"], :name => "index_rs_creation_genres_on_genre_id"

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "invited"
    t.datetime "key_timestamp"
    t.string   "role"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

end
