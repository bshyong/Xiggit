class SearchController < ApplicationController

layout 'application'


def index
	# @results = BookPost.find_with_index(params[:terms])
	 @results2 = cb_search(nil, nil, params[:terms])
	 @results = BookPost.paginate_search params[:terms], :per_page => 5, :page => params[:page]
	 
	 @book_bag = find_bag
	 
end


def search
  
end

private

def cb_search author = nil, title = nil, keywords = nil
  
   if author.blank?
    @author = ''
  else
    @author = '&author=' + author
  end
  
  if title.blank?
    @title = ''
  else
    @title = '&title=' + title
  end
  
  if keywords.blank?
    @keywords = ''
  else
    @keywords = '&keywords=' + keywords
  end
    
  @call_url = 'http://api.campusbooks.com/6/rest/search?key=xiSU31GxwkRKshbeZ2nx' + @author + @title + @keywords + '&page=1'

  doc = XML::Reader.file(@call_url)
  
  @results = []
  
  while doc.read

      if doc.name == 'isbn13'
        unless @results.include?(doc.expand)
       @results << doc.expand
     end
       doc.move_to_element
   end

  end
doc.close
return @results

end  


end
