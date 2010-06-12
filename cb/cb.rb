#Xiggit CampusBooks Module
#Author: Varun Sampath <vsampath@seas.upenn.edu>
#with help from Marshall Roch's 2009 Campus Books ruby gem

require 'httparty'

module Cb
  include HTTParty
  format :xml
  @api_key = 'xiSU31GxwkRKshbeZ2nx'
  base_uri 'http://api.campusbooks.com/4/rest'

  def self.api_key
    @api_key
  end
  
  #kinda Copyright (c) 2009 Marshall Roch
  def self.get_response(path, options={})
    res = self.get(path, options)
    case res['response']['status']
      when 'ok'
        return res['response']

      when 'error'
        return { 'page' => 'error' }
    end
  end
  #end Copyright
  
  def self.book_info(isbn)
    return self.get_response('/bookinfo', :query => { :isbn => isbn, :key => @api_key })['page']
  end

  def self.search(options={})
    { :title => '', :author => '', :keywords => '' }.merge!(options)
    options[:key] = @api_key
    return self.get_response('/search', :query => options)['page']['results']['book']
  end
end
