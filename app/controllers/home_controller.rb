class HomeController < ApplicationController

    layout 'application'
    
    USER_ID, PASSWORD = 'demo@xiggit.com', 'demopass'
    before_filter :authenticate, :only => [:login]

    # this code can probably be refactored by using a :before_filter
  
    def index
      if @current_user
         if @current_user.new == 0
            redirect_to :action => 'home'
          else
            
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).school_name != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:school_name, @current_user.facebook_session.user.education_history.last.name)
        end
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).first_name != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:first_name, @current_user.facebook_session.user.first_name)
        end
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).last_name != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:last_name, @current_user.facebook_session.user.last_name)
        end

      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).new != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:new, '1')
        end

            @book_bag = find_bag
          end
      else
         redirect_to :action => 'login'
      end
  end

    def home
        if @current_user
            @book_bag = find_bag
        else
            redirect_to :action => 'login'
        end

        
    end

    def login
        if @current_user
        redirect_to :action => 'home'
        else
        render :layout => 'login'
        end
    end

    def privacy

        @book_bag = find_bag

        unless @current_user
        render :layout => 'login'
        end
    end

    def terms
        @book_bag = find_bag
        unless @current_user
        render :layout => 'login'
        end
    end

    def about
        @book_bag = find_bag
        unless @current_user
        render :layout => 'login'
        end
    end

    def help
        @book_bag = find_bag
        unless @current_user
        render :layout => 'login'
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
