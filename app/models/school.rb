class School < ActiveRecord::Base

    has_many :book_posts
    has_many :users
    has_many :courses

end
