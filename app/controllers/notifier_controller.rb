#Author: Benjamin Shyong <bshyong@seas.upenn.edu>

class NotifierController < ApplicationController

    def contact_seller
        # heroku doesn't give us free workers...
     #   Notifier.delay.deliver_contact_seller(params[:email], params[:sender_email], params[:sender_name], params[:book_title])
       Notifier.deliver_contact_seller(params[:email], params[:sender_email], params[:sender_name], params[:book_title])
         render :update do |page|
            page.replace_html 'contact_seller_link_' + params[:post_id], :partial => 'user/seller_contacted'
            page.visual_effect :highlight, 'contact_seller_link_' + params[:post_id]
           end
        return if request.xhr?
          
    end
end
