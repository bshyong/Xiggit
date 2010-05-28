class SearchController < ApplicationController

layout 'application'

def index
	# @results = BookPost.find_with_index(params[:terms])
	 @results = BookPost.paginate_search params[:terms], :page => 1, :per_page => 5
	 @book_bag = find_bag
end


end
