class HomeController < ApplicationController

    layout 'application'

    def index
      if @current_user
         if @current_user.new == 0
            redirect_to :action => 'home'
          else

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

end
