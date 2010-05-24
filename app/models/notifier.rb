class Notifier < ActionMailer::Base
  

  def contact_seller(recipient, sender_email, sender_name, title)
    subject    'Somebody wants to buy your book!'
    recipients recipient
    from       "\"Xiggit\" <no-reply@xiggit.com>"
    sent_on    Time.now
    
    body       :sender_email => sender_email, :sender_name => sender_name, :book_title => title
  end

end
