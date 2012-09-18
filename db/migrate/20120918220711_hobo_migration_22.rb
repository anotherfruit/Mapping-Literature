class HoboMigration22 < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string   :title
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :rs_fragment_topics do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :topic_id
      t.integer  :fragment_id
    end
    add_index :rs_fragment_topics, [:topic_id]
    add_index :rs_fragment_topics, [:fragment_id]
  end

  def self.down
    drop_table :topics
    drop_table :rs_fragment_topics
  end
end
