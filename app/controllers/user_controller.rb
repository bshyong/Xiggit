class UserController < ApplicationController

 # before_filter :require_current_user

    layout 'application'
    
    def hide_help
        # set the value in the 'new' column of the 'user' table to a value of 0
        # signifies that the user is no longer new
        
        current_user.update_attribute(:new, 0)
        
        redirect_to :controller => 'home', :action => 'home'
        flash[:notice] = fading_flash_message("Done.  There's a help link at the bottom of the page if you need it.", 5)
    end

    def save_email

    @email = params[:email].fetch('to_s')

    @email_save = current_user.update_attributes(:email => @email)

        if @email_save
          render :update do |page|
            page.replace 'warning', :partial => 'user/save_email'
            page.visual_effect :highlight, 'notice'
            page.visual_effect :fade, 'notice', :duration => 1.0, :from => 1.0, :to => 0.0, :delay => 3
            page.reload
          end

          else
              render :update do |page|
           # page.replace 'warning', :partial => 'user/save_email_failed'
            page.visual_effect :highlight, 'warning'
              end
          end

        end
    end




