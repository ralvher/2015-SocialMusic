require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	test "login with invalid information" do
	    get login_path
	    assert_template 'static_pages/home'
	    post login_path, session: { email: "", password: "" }
	    assert_template 'static_pages/home'
	    assert_not flash.empty?
	    get root_path
	    assert flash.empty?
  	end
end
