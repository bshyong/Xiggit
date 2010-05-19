class CourseController < ApplicationController

def create
		@course = Course.new(params[:course])
		if @course.save
			 render :partial => 'user/new_course', :object => @course, :update => 'checklist'
		else
			redirect_to_root_path
		end
end

def checked
    Course.find_by_name_and_uid(params[:course_name], @current_user.facebook_id).checked
end

def check
    Course.find_by_name_and_uid(params[:course_name], @current_user.facebook_id).update_attribute(:checked, 1)
    
end

def delete
    
end

end
