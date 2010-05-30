module SearchHelper
  
  require 'nokogiri'
  require 'open-uri'
  
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

  @doc = Nokogiri::HTML(open(@call_url))
  
  @results = []
  @doc.xpath('//results/book/title').each do |r|
    @results << r.inner_text()
  end
  
 # @results = @doc.xpath('//results/book/title').inner_text()

end  
  
end
