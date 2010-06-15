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

def fast_auto_complete_field(field_id, options={})
  div_id = "#{field_id}_auto_complete"
  url = options.delete(:url) or raise "url required"
  options = options.merge(:tokens => ',', :frequency => 0 )
  script = javascript_tag <<-end
    new Ajax.Request('#{url}', {
      method: 'get',
      onSuccess: function(transport) {
        new Autocompleter.Local('#{field_id}', '#{div_id}', eval(transport.responseText), #{options.to_json});
      }
    });
  end
  content_tag 'div', script, :class => 'auto_complete', :id => div_id
end


end
