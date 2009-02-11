require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session" do # FIXME
    assert_difference('Session.count') do
      post :create, :session => { }
    end

    assert_redirected_to session_path(assigns(:session))
  end

  test "should destroy session" do # FIXME
    assert_difference('Session.count', -1) do
      delete :destroy
    end

    assert_redirected_to sessions_path
  end
end
