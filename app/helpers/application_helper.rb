# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    
def checked x
    if x.checked == 1
       # Course.find_by_name_and_uid(params[:course_name], @current_user.facebook_id).checked == 1
        return true
    else
        return false
    end
end

end
