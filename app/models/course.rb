class Course < ActiveRecord::Base
    belongs_to :user
    has_and_belongs_to_many :book_posts
    belongs_to :school
end
