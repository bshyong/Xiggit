class ConnectController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => ['uninstall', 'invite']
  before_filter :require_current_user, :only => ['invite']
 # after_filter :set_user_info, :only => ['login']

  def login
    redirect_to root_path and return unless request.xhr?

#     if User.find_by_facebook_id(@current_user.facebook_session.user.id).school_name.nil? || User.find_by_facebook_id(@current_user.facebook_session.user.id).school_name.blank?
#        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:school_name, @current_user.facebook_session.user.education_history.last.name)
#       end
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).first_name != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:first_name, @current_user.facebook_session.user.first_name)
        end
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).last_name != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:last_name, @current_user.facebook_session.user.last_name)
        end
      unless User.find_by_facebook_id(@current_user.facebook_session.user.id).new != nil
        User.find_by_facebook_id(@current_user.facebook_session.user.id).update_attribute(:new, '1')
        end
#set_user_info

     render :update do |page|
         page.redirect_to(:controller => 'home', :action => 'index')
     end
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    clear_facebook_session_information

    redirect_to root_path and return unless request.xhr?

    #render :partial => 'shared/fb_connect'

      render :update do |page|
          page.replace 'page', :partial => 'home/logged_out'
      end
  end

  # http://wiki.developers.facebook.com/index.php/Post-Remove_URL
  def uninstall
    User.find_by_facebook_id(params[:fb_sig_user]).destroy rescue nil
    render :nothing => true
  end

  def connection_required
   # @goto_url = flash[:goto_url] || root_path
    render :layout => 'login'
  end

  def publish_user_actions
    if request.post?
      @user_action_to_publish = SamplePublisher.create_sample(@current_user)
    end
  end

  def user_action
    if request.post?
      @user_action_to_publish = SamplePublisher.create_sample(@current_user)
    end
  end

  # Processing ConnectController#invite (for 127.0.0.1 at 2009-04-13 15:45:21) [POST]
  # Parameters: {"ids"=>["1685645931"], "mfs_typeahead_req_form_49e3c070ee9e31811502384"=>"Start Typing a Friend's Name"}
  def invite_friends
  end
  
end

