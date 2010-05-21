class BookBagController < ApplicationController

    def add_to_bag
        @book_bag = find_bag
        @book_bag.add_book(params[:id])
        respond_to do |format|
            format.js
        end

    end

    def remove_from_bag
        @book_bag = find_bag
        @book_bag.remove_book(params[:id])
         respond_to do |format|
            format.js
          end
    end

    def empty_bag
        session[:book_bag] = nil
        render :partial => 'user/bookbag', :update => 'bookbag'
    end


private #anything under this line is prevented from being called as an action on the controller

    def find_bag # the ||= is a conditional operator, if :book_bag exists, its value is returned, otherwise a new BookBag object is created
        session[:book_bag] ||= BookBag.new
    end

end
