module SearchHelper
  
def cb_search author, title, keywords
  
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
    
  @url = 'http://api.campusbooks.com/6/rest/search?key=xiSU31GxwkRKshbeZ2nx' + @author + @title + @keywords + '&page=1'

  doc = XML::Reader.file(@url)
  
  @results = []
  
  while doc.read

      if doc.name == 'book'
       @results << doc.expand 
       doc.move_to_element
   end

  end
doc.close
return @results

end  

end
