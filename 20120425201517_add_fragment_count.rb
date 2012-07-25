class AddFragmentCount < ActiveRecord::Migration
  def self.up
    add_column :creations, :fragment_count, :integer

    Creation.reset_column_information
    Creation.all.each do |creation|
      creation.fragment_count = creation.fragments.count
      creation.save!
    end
  end

  def self.down
    remove_column :creations, :fragment_count
  end
end
- 
