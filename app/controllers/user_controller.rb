class UserController < ApplicationController

  before_filter :require_current_user

  layout 'application'

    def friends
        render :partial => 'user/friends'
    end

    def hide_help
        # set the value in the 'new' column of the 'user' table to a value of 0
        # signifies that the user is no longer new
        
        User.find_by_facebook_id(@current_user.facebook_id).update_attribute(:new, 0)
        
        redirect_to :controller => 'home', :action => 'home'
        flash[:notice] = fading_flash_message("Done.  There is help link at the bottom of the page if you ever need it.", 5)
    end

end



