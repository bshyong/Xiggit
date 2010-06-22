class AddBookPostManualState < ActiveRecord::Migration
  def self.up
    add_column :book_posts, :manual, :boolean, :default => false
  end

  def self.down
    remove_column :book_posts, :manual
  end
end
