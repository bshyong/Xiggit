class BookPostController < ApplicationController

  before_filter :require_current_user
 layout 'application'
  
	def list
 @book_posts = BookPost.paginate_by_school_name @current_user.school_name, :order => params[:order] || "created_at DESC", :page => params[:page]
  @book_bag = find_bag
  end

 	def show
		@book_post = BookPost.find(params[:id])
    render :partial => 'book_post/show'
    # users need to be able to access mailers & messaging functions here
    # messaging functions should be disabled when showing own posts
	end
  
	def new
      @book_bag = find_bag
	end

  
	def create
		@book_post = BookPost.new(params[:book_post])
		if @book_post.save
			redirect_to :action => 'list'
		else
			render :action => 'new'
		end
	end
	def edit
      # users should only be able to edit their own posts
	end
	def update
	end
	def delete
      # users should only be able to delete their own posts
      # should we put in an auto-expire option?
	end
  	def auto_complete_for_book_post_course

        # this will be replaced with a faster autocomplete;
        # where entries are loaded into javascript array
        # and auto_completed on the client side

		file = "UPenn_courses.txt"
		@courses=[]

		string = params[:book_post][:course].downcase
		File.open( file ) do |io|
			io.each {|line| line.chomp! ; @courses << line if (line.downcase =~ /^#{string}/) and (@courses.length < 15)}
		end
		render :partial => 'courses'
	end

    private #anything under this line is prevented from being called as an action on the controller

    def find_bag # the ||= is a conditional operator, if :book_bag exists, its value is returned, otherwise a new BookBag object is created
        session[:book_bag] ||= BookBag.new
    end


end
