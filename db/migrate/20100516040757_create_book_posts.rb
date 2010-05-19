class CreateBookPosts < ActiveRecord::Migration
  def self.up
    create_table :book_posts do |t|
	t.column :isbn, :string
	t.column :title, :string
	t.column :author, :string
	t.column :publisher, :string
	t.column :ed, :string
	t.column :year, :integer
	t.column :price, :float
	t.column :course, :string
	t.column :condition, :string
	t.column :comments, :text
	t.column :uid, :integer
	t.column :created_at, :timestamp
	t.column :updated_at, :timestamp
  t.column :school_name, :string

    end

      add_index :book_posts, :uid, :name => 'uid_ix'
      add_index :book_posts, :price, :name => 'price_ix'
      add_index :book_posts, :created_at, :name => 'created_at_ix'
      add_index :book_posts, :course, :name => 'course_ix'
      add_index :book_posts, :condition, :name => 'condition_ix'
      add_index :book_posts, :school_name, :name => 'school_name_ix'
      

  end

  def self.down
    drop_table :book_posts
  end
end
