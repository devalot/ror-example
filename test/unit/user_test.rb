################################################################################
require('test_helper')

################################################################################
class UserTest < ActiveSupport::TestCase
  
  ##############################################################################
  test "ensure we have authentication working correctly" do
    user = User.new(:first_name => 'John', :last_name => 'Doe', :email => 'Fake@example.com')
    user.password = 'fubar'
    user.password_confirmation = 'not-fubar'
    assert(!user.valid?)
    
    user.password_confirmation = 'fubar'
    assert(user.valid?)
    assert(user.save)
    
    found = User.where(:email => 'fake@example.com').first
    assert_equal(user, found)
    assert(found.authenticate('fubar'))    
    assert(!found.authenticate('something else'))
    
    # Try using our class method shortcut
    assert_equal(user, User.authenticate('fake@example.COM', 'fubar'))
    assert(!User.authenticate('fake@example.com', 'fake'))
  end
end
