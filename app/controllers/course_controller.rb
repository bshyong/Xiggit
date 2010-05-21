class CourseController < ApplicationController

def create
		@course = Course.new(params[:course])
		if @course.save
			 render :partial => 'course/new_course', :object => @course, :update => 'checklist'
		else
			redirect_to_root_path
		end
end

def check
    @course = Course.find_by_name_and_uid(params[:course_name], @current_user.facebook_id)

    if @course.checked == 0 || @course.checked == nil
        @course.update_attribute(:checked, 1)
        render :partial => 'course/check'
    else
        @course.update_attribute(:checked, 0)
        render :partial => 'course/uncheck'
    end

end

def delete
    @course = Course.find_by_name_and_uid(params[:course_name], @current_user.facebook_id)
    @course.destroy
    render :partial => 'course/delete'
end

end
