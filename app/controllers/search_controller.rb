class SearchController < ApplicationController

layout 'application'

def keyword_search
		@results = BookPost.find_with_index('boink')

end


end
