# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :facebook_session
  
  before_filter :set_assumptions
  before_filter :create_facebook_session
  before_filter :set_current_user

  def set_assumptions
    @app_settings = '{}'
  end
  private :set_assumptions

  def set_current_user
    if facebook_session && facebook_session.secured?
      if session[:user_id] 
        @current_user ||= User.find(session[:user_id]) rescue nil
        @current_user = nil if @current_user && @current_user.facebook_id != facebook_session.user.id
      end

      if @current_user.nil?
        @current_user = User.find_by_facebook_id(facebook_session.user.id) || User.create!(:facebook_id => facebook_session.user.id, :facebook_session_key => facebook_session.session_key)
        session[:user_id] = @current_user.id if @current_user
      end

      if @current_user && facebook_session.session_key != @current_user.facebook_session_key
        @current_user.update_attribute(:facebook_session_key, facebook_session.session_key)
      end

    else
      session[:user_id] = nil
      @current_user = nil
      clear_facebook_session_information
    end

  end
  private :set_current_user

  def require_current_user
    return true if @current_user
    flash[:goto_url] = request.url
    redirect_to connection_required_url
  end

  private :require_current_user

  # custom error handler
unless ActionController::Base.consider_all_requests_local
    rescue_from Exception,                            :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,         :with => :render_not_found
    rescue_from ActionController::RoutingError,       :with => :render_not_found
    rescue_from ActionController::UnknownController,  :with => :render_not_found
    rescue_from ActionController::UnknownAction,      :with => :render_not_found
  end

    private

  def render_not_found(exception)
    log_error(exception)
    render :template => "/error/404.html.erb", :status => 404
  end

  def render_error(exception)
    log_error(exception)
    notify_hoptoad(exception)
    render :template => "/error/500.html.erb", :status => 500
  end  


end
