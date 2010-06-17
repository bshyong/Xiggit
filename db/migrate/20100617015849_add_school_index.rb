class AddSchoolIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :school_name, :name => 'school_name_ix'
  end

  def self.down
    remove_index :users, :school_name
  end
end
