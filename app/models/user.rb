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



validates_presence_of     :email, :message => 'email cannot be blank!'
validates_length_of       :email,    :within => 3..100
validates_format_of :email,
    :with => /^([A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})$/i
validates_uniqueness_of   :email, :case_sensitive => false, :message => 'that email is already in use!'
attr_accessible  :email


end
