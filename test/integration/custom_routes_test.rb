require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "that /login route opens the login page" do
    get '/login'
    assert_response :ok
  end

   test "that /logout route opens the login page" do
    get '/logout'
    assert_response :redirect
    assert_redirected_to '/'
  end

  test "that /register route opens the sign up page" do
    get '/register'
    assert_response :ok
  end

  test "that a profile page works" do
    get '/jasonz'
    assert_response :ok
  end
end
