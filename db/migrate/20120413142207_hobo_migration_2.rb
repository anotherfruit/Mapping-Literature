class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :rs_creation_genres, :genre_id, :integer
    add_column :rs_creation_genres, :creation_id, :integer

    add_index :rs_creation_genres, [:genre_id]
    add_index :rs_creation_genres, [:creation_id]
  end

  def self.down
    remove_column :rs_creation_genres, :genre_id
    remove_column :rs_creation_genres, :creation_id

    remove_index :rs_creation_genres, :name => :index_rs_creation_genres_on_genre_id rescue ActiveRecord::StatementInvalid
    remove_index :rs_creation_genres, :name => :index_rs_creation_genres_on_creation_id rescue ActiveRecord::StatementInvalid
  end
end
