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
  @isbn_array = []
  @results = []
  
  @doc.xpath('//results/book/isbn13').slice(0,3).each do |r|
    @isbn_array << r.inner_text()
  end

 @isbn_array.each do |i|
   @price_url = 'http://api.campusbooks.com/6/rest/prices?key=xiSU31GxwkRKshbeZ2nx&isbn=' + i.to_s
   @price = Nokogiri::HTML(open(@price_url))
   @price.xpath('//offer').slice(0,1).each do |o|
     @h = {}
     @h["price"] = o>('price')
     @h["isbn"] = o>('isbn13')
   @results << @h
   end
end
    
    return @results
    
  
 # @results = @doc.xpath('//results/book/title').inner_text()

end  
  
end
