################################################################################
# FactoryGirl is a nice replacement for test fixtures. For more
# information please see: 
#
# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
#
FactoryGirl.define do
  
  ##############################################################################
  factory(:user) do
    first_name('John')
    last_name('Doe')
    password('fubar')
    password_confirmation('fubar')
    sequence(:email) {|n| "person#{n}@example.com"}
  end
  
  ##############################################################################
  factory(:car) do
    name('Toyota Land Cruiser')
    user
  end
end
