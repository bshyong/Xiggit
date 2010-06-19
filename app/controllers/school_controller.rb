class SchoolController < ApplicationController
  
    def list
    @schools = School.find(:all)
  end
  
  def delete
    @school = School.find_by_id(params[:school_id])
    @school.destroy
    render :partial => 'course/delete'
  end

end
