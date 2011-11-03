################################################################################
require('test_helper')

################################################################################
class LoginFlowTest < ActionDispatch::IntegrationTest
  
  ##############################################################################
  test "user can login and then log out" do
    user = FactoryGirl.create(:user)
    
    # Going to / should redirect us to login
    get('/')
    assert_response(:redirect)
    assert_redirected_to(login_path)

    # Going to /login should return the login form
    get('/login')
    assert_response(:success)
    assert_template(:new)
    
    # Posting to /sessions should log us in
    post('/sessions', :user => {:email => user.email, :password => 'fubar'})
    assert_response(:redirect)
    assert_redirected_to(root_path)
    
    # Going to / should show us our cars
    get('/')
    assert_response(:success)
    assert_template(:index)
    assert(assigns(:cars))
    
    # Going to /logout should log us out
    get('/logout')
    assert_response(:redirect)
    assert_redirected_to(root_path)
    
    # Going to / should redirect us to login
    get('/')
    assert_response(:redirect)
    assert_redirected_to(login_path)
  end
end
