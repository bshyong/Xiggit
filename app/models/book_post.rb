#Book Post Model
#Author: Varun Sampath <vsampath@seas.upenn.edu>
#Contributor: Benjamin Shyong <bshyong@seas.upenn.edu>


require 'net/http'
#require 'cb'

class BookPost < ActiveRecord::Base

    belongs_to :school
    belongs_to :user
    
    acts_as_indexed :fields => [:title, :author, :isbn, :comments, :ed, :course]

    cattr_reader :per_page
    @@per_page = 5

	def before_validation
		if self.isbn
			self.isbn = self.isbn.gsub("-","").strip
		end
		#uses WorldCat's API to get a hash full of book metadata
		@data = eval(Net::HTTP.get(URI.parse("http://xisbn.worldcat.org/webservices/xid/isbn/#{self.isbn}?method=getMetadata&format=ruby&fl=publisher,author,ed,title,year")))
#	@data = Cb::book_info(self.isbn)
  end

	validates_numericality_of :price, :message => "-  numbers only. no letters!"
	validates_presence_of :author, :message => "can't be blank!", :if => :skip_isbn_validation
	validates_presence_of :title, :message => "can't be blank!", :if => :skip_isbn_validation


	def validate
		errors.add(:price, "-  should be a positive value") if price.nil? || price < 0.01
		unless skip_isbn_validation
		if @data["stat"] != "ok"
			errors.add(:isbn)
		end
end				
	end

	def before_save
	  
	  unless skip_isbn_validation
      unless @data.blank?
    self.title = @data["list"][0]["title"]
		self.author = @data["list"][0]["author"]
		self.publisher = @data["list"][0]["publisher"]
		self.year = @data["list"][0]["year"].to_i
    self.ed = @data["list"][0]["ed"]
    self.ed ||= 'n/a'.to_s
# conditional assignment sets edition to "n/a" if the hash didn't provide a value

      #for some reason, isbns are returning invalid when using cb, so temporary switch back to WorldCat
      # NOTE: WorldCat has a limit of 1000 queries per day, we should switch to CB or Amazon.
#    self.isbn = @data["isbn13"]
#    self.title = @data["title"]
#    self.author = @data["author"]
#    self.publisher = @data["publisher"]
#    self.ed = @data["edition"]
#    self.year = @data["published_date"][0..4].to_i
      end
    end
    
      if self.comments.blank?
        self.comments = 'No comments.'
      end
       if self.course.blank?
        self.course = 'n/a'
      end
          if self.publisher.blank?
        self.publisher = 'n/a'
      end
          if self.year.blank?
        self.year = 'n/a'
      end
          if self.ed.blank?
        self.ed = 'n/a'
      end
	end
	
	def skip_isbn_validation
		if self.manual == true
return true
	else
	  return false
	end
	end
end
