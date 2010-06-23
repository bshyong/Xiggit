class AdminController < ApplicationController
  
       USER_ID, PASSWORD = 'admin', '&1#--gv*;^/#;3J0UB+c)=6B1CBvS^3h'
    before_filter :authenticate, :ensure_user
    skip_before_filter :verify_authenticity_token, :except => [:list, :create, :delete]
  
  in_place_edit_for :school, :name
   
  def create_school
		@school = School.new(params[:school])
		if @school.save
			 render :partial => 'school/new_school', :object => @school, :update => 'list'
		else
			redirect_to :action => 'list_schools'
		end
end
  
  def index
    @users = User.find(:all)
  end
  
  def all_users
    @users = User.find(:all)
  end
  
    def list_schools
    @schools = School.find(:all)
  end
  
  def delete_school
    @school = School.find_by_id(params[:school_id])
    @school.destroy
    render :partial => 'school/delete'
  end
  
  def list_users
    @users = User.find_all_by_school_name(params[:school_name])
    @school = params[:school_name]
  end
  
  private
   def authenticate
      authenticate_or_request_with_http_basic do |id, password| 
          id == USER_ID && password == PASSWORD
      end
   end
  
end
