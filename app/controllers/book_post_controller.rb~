#Author: Benjamin Shyong <bshyong@seas.upenn.edu>

class BookPostController < ApplicationController

require 'net/http'

 #before_filter :require_current_user
 before_filter :ensure_school

 layout 'application'

 skip_before_filter :verify_authenticity_token, :except => [:list, :show, :show_partial, :create, :new, :edit, :update, :delete]

 in_place_edit_for :book_post, :title
 in_place_edit_for :book_post, :author
 in_place_edit_for :book_post, :year
 in_place_edit_for :book_post, :ed
 in_place_edit_for :book_post, :publisher
 in_place_edit_for :book_post, :course
 in_place_edit_for :book_post, :price
 in_place_edit_for :book_post, :comments

	
	def ensure_school
        if current_user.school_name.blank?
          redirect_to :controller => 'home', :action => 'find_school'
        end
      end
	
	def list
 @book_posts = BookPost.paginate_by_school_name current_user.school_name, :order => params[:order] || "created_at DESC", :page => params[:page]
  @book_bag = find_bag
  end

 	def show
		@book_post = BookPost.find(params[:id])
    # users need to be able to access mailers & messaging functions here
    # messaging functions should be disabled when showing own posts
	end

  	def show_partial
		@book_post = BookPost.find(params[:id])
    render :partial => 'book_post/show'
    # users need to be able to access mailers & messaging functions here
    # messaging functions should be disabled when showing own posts
	end
  
	def new
      @book_bag = find_bag
	end

  
	def create
#		@book_post = BookPost.new(params[:book_post])
#		flash[:notice] = fading_flash_message("Book saved successfully.", 3)
#		if @book_post.save
#			redirect_to :action => 'list'
#		else
#			render :action => 'new'
#		end
if session[:unsaved_book]
  @book_post = BookPost.new(params[:book_post].reverse_merge(session[:unsaved_book]))
else
  @book_post = BookPost.new(params[:book_post])
end
  
  if @book_post.save
    session.delete[:unsaved_book]
    flash[:notice] = fading_flash_message("Book saved successfully.", 3)
    redirect_to :action => 'list'
  else
    if @book_post.errors.on(:isbn) && @book_post.errors.length == 1
      session[:unsaved_book] = params[:book_post]
      flash[:warning] = 'Sorry, ISBN lookup failed.  Please enter book data manually.<br />Don\'t worry about your information from the previous form, we saved it for you!'
      redirect_to :action => 'details'
    else
      render :action => 'new'
    end
  end
end

def manual_create
  if session[:unsaved_book]
  @book_post = BookPost.new(params[:book_post].reverse_merge(session[:unsaved_book]))
else
  @book_post = BookPost.new(params[:book_post])
end
if @book_post.save
session.delete(:unsaved_book)
flash[:notice] = fading_flash_message("Book saved successfully.", 3)
redirect_to :action => 'list'
else
  render :action => 'details'
end
  
end

	def delete

      @book_post = BookPost.find_by_id(params[:id])
      @book_post.delete
      flash[:notice] = fading_flash_message("Book post successfully deleted.", 3)
      redirect_to :controller => 'home', :action => 'home'

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
			io.each {|line| line.chomp! ; @courses << line if (line.downcase =~ /^#{string}/) and (@courses.length < 10)}
		end
		render :partial => 'courses'
	end
	
	def lookup_courses
	  	file = "UPenn_courses.txt"
	  	
		@courses=[]
		File.open( file ) do |io|
			io.each {|line| line.chomp! ; @courses << line }
		end
		response.headers['Content-Type'] = "text/javascript"
	  render :layout => false
end

    private #anything under this line is prevented from being called as an action on the controller

    def find_bag # the ||= is a conditional operator, if :book_bag exists, its value is returned, otherwise a new BookBag object is created
        session[:book_bag] ||= BookBag.new
    end

    
end
