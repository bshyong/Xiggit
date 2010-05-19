class UserController < ApplicationController

  before_filter :require_current_user

  layout 'application'

    def friends
        render :partial => 'user/friends'
    end


end



