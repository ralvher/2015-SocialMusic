require 'test_helper'
#test autentificacion por email
class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activación de Cuenta SocialMusic", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@socialmusic.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end
