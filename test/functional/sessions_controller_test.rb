################################################################################
require('test_helper')

################################################################################
class SessionsControllerTest < ActionController::TestCase
  
  ##############################################################################
  test "can log in with a valid password" do
    user = FactoryGirl.create(:user)
    post(:create, :user => {:email => user.email, :password => 'fubar'})
    assert_response(:redirect)
    assert_redirected_to(root_path)
    assert_equal(user.id, session[:user_id])
  end
  
  ##############################################################################
  test "cannot log in with a bad password" do
    user = FactoryGirl.create(:user)
    post(:create, :user => {:email => user.email, :password => 'BAD'})
    assert_response(:success) # the login form was rendered
    assert_template(:new)
    assert(session[:user_id].blank?)
  end
  
  ##############################################################################
  test "user can log out" do
    user = FactoryGirl.create(:user)
    
    # GET /sessions/destroy with no params and a session that
    # indicates a logged in user.
    get(:destroy, {}, {:user_id => user.id})
    
    assert_response(:redirect)
    assert_redirected_to(root_path)
    assert(session[:user_id].blank?)
  end
end
