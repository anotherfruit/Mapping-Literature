class HoboMigration18 < ActiveRecord::Migration
  def self.up
    add_column :fragments, :user_id, :integer

    add_index :fragments, [:user_id]
  end

  def self.down
    remove_column :fragments, :user_id

    remove_index :fragments, :name => :index_fragments_on_user_id rescue ActiveRecord::StatementInvalid
  end
end
