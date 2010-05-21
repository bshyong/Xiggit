class User < ActiveRecord::Base
  
    belongs_to :school
    has_many :book_posts
    has_many :courses
    

  #
  # Borrowed from facebooker_authentication plugin.
  #
  def facebook_session
    return nil if facebook_session_key.blank?
    @facebook_session ||= returning Facebooker::Session.create do |session| 
      session.secure_with!(facebook_session_key, facebook_id, 1.hour.from_now) 
      Facebooker::Session.current = session
    end
  end
end
