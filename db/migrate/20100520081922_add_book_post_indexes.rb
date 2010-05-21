class AddBookPostIndexes < ActiveRecord::Migration
  def self.up
      add_index :book_posts, :isbn, :name => 'isbn_ix'
      add_index :book_posts, :id, :name => 'bp_id_ix'
  end

  def self.down
      remove_index :book_posts, :isbn
      remove_index :book_posts, :id
  end
end
