class SearchController < ApplicationController

layout 'application'

def index
	# @results = BookPost.find_with_index(params[:terms])
	 @results = BookPost.paginate_search params[:terms], :per_page => 1, :page => params[:page]
	 @book_bag = find_bag
end


end
