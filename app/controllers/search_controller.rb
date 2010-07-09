class SearchController < ApplicationController

layout 'application'
  require 'nokogiri'
  require 'open-uri'

def index
    
  # cb_search(nil, nil, params[:terms])  # This method is too slow!  Need to optimize the code.
	 @results = BookPost.paginate_search params[:terms], :per_page => 7, :page => params[:page]
	 @results = @results.delete_if { |r| r.school_name != current_user.school_name }
	 @book_bag = find_bag
end

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
    @keywords = '&keywords=' + keywords.gsub(' ', '%20')
  end

  @call_url = 'http://api.campusbooks.com/6/rest/search?key=xiSU31GxwkRKshbeZ2nx' + @author + @title + @keywords + '&page=1'

  @doc = Nokogiri::XML(open(@call_url))
  @hash_array = []
  @hash_array2 = []

  @doc.xpath('//results/book').slice(0,3).each do |r|
    @h ={}
    @h["isbn"] = r>('isbn13')
    @h["title"] = r>('title')
    @h["author"] = r>('author')
    @h["image"] = r>('image')
    @hash_array << @h
  end

 @hash_array.each do |i|
   @isbn = i['isbn']
   @price_url = 'http://api.campusbooks.com/6/rest/prices?key=xiSU31GxwkRKshbeZ2nx&isbn=' + @isbn.inner_text()
   Nokogiri::XML(open(@price_url)).xpath('//offer').slice(0,1).each do |o|
     @h = {}
     @h["price"] = o>('price')
     @h["isbn"] = @isbn
     @h["link"] = o>('link')
   @hash_array2 << @h
end
end
  @results2 = @hash_array.zip(@hash_array2).collect { |array| array.inject(&:merge) }
   
end  

end
