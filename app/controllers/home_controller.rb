class HomeController < ApplicationController

    layout 'application'
    
  #  USER_ID, PASSWORD = 'demo', 'demopass'
 #   before_filter :authenticate, :only => [:login, :home]

    # this code can probably be refactored by using a :before_filter
  
    def index
      if current_user
        if current_user.school_name.blank?
          redirect_to :action => 'find_school'
        else
         if current_user.new == 0
            redirect_to :action => 'home'
          else
            @book_bag = find_bag
          end
        end
      else
         redirect_to :action => 'login'
    end
  end

    def home
        if current_user
           if current_user.school_name.blank?
          redirect_to :action => 'find_school'
        else          
            @book_bag = find_bag
          end
        else
            redirect_to :action => 'login'
        end
    end

    def login
        if current_user
        redirect_to :action => 'home'
        else
        render :layout => 'login'
        end
    end

    def privacy

        @book_bag = find_bag

        unless current_user
        render :layout => 'login'
        end
    end

    def terms
        @book_bag = find_bag
        unless current_user
        render :layout => 'login'
        end
    end
    
    def about
        @book_bag = find_bag
        unless current_user
        render :layout => 'login'
        end
    end

    def help
        @book_bag = find_bag
        unless current_user
        render :layout => 'login'
        end
    end

def find_school
  render :layout => 'login'
  unless curret_user
    redirect_to :action => 'login'
  end
  
end

   
def set_school
  
if School.find_by_name(params[:name])
  current_user.update_attribute(:school_name, params[:name])
  flash[:notice] = fading_flash_message("School saved successfully!", 3)
  redirect_to :action => 'index'
else
  flash[:warning] = 'The school you entered could not be found! <br />Please send a message to help@xiggit.com if you think this is a mistake.'
  render :action => 'find_school', :layout => 'login'
end
end
    
private #anything under this line is prevented from being called as an action on the controller

    def find_bag # the ||= is a conditional operator, if :book_bag exists, its value is returned, otherwise a new BookBag object is created
        session[:book_bag] ||= BookBag.new
    end
    
     def authenticate
      authenticate_or_request_with_http_basic do |id, password| 
          id == USER_ID && password == PASSWORD
      end
   end
   
end
   


