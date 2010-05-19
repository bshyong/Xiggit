class CreateSchools < ActiveRecord::Migration
  def self.up
      create_table :schools do |s|
      s.string :name
      s.timestamps
      end
  end

  def self.down
      drop_table :schools
  end
end