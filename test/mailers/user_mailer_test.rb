require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "confirmation" do
    angie = users(:angie)
    mail = UserMailer.confirmation(angie)
    assert_equal "Confirmation Instructions", mail.subject
    assert_equal [angie.email], mail.to
    assert_equal [User::MAILER_FROM_EMAIL], mail.from
    assert_match "Confirmation Instructions", mail.body.encoded
  end

  test "password reset" do
    angie = users(:angie)
    mail = UserMailer.password_reset(angie)
    assert_equal "Password Reset Instructions", mail.subject
    assert_equal [angie.email], mail.to
    assert_equal [User::MAILER_FROM_EMAIL], mail.from
    assert_match "Password Reset Instructions", mail.body.encoded
  end
end
