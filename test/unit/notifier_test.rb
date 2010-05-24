require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "contact_seller" do
    @expected.subject = 'Notifier#contact_seller'
    @expected.body    = read_fixture('contact_seller')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_contact_seller(@expected.date).encoded
  end

end
