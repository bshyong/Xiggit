class SchoolController < ApplicationController
  
     USER_ID, PASSWORD = 'admin', '&1#--gv*;^/#;3J0UB+c)=6B1CBvS^3h'
    before_filter :authenticate, :ensure_user
    skip_before_filter :verify_authenticity_token, :except => [:list, :create, :delete]
  
  in_place_edit_for :school, :name
  
  def create
		@school = School.new(params[:school])
		if @school.save
			 render :partial => 'school/new_school', :object => @school, :update => 'list'
		else
			redirect_to :action => 'list'
		end
end
  
    def list
    @schools = School.find(:all)
  end
  
  def delete
    @school = School.find_by_id(params[:school_id])
    @school.destroy
    render :partial => 'school/delete'
  end
  
  private
   def authenticate
      authenticate_or_request_with_http_basic do |id, password| 
          id == USER_ID && password == PASSWORD
      end
   end
    
end