class Car < ActiveRecord::Base
  
  ##############################################################################
  attr_accessible(:name)
  
  ##############################################################################
  # Validate that the name of a car is unique, but only for a single
  # user.  That is, a single user can't have more than one car with
  # the same name, but two users can have a car with the same name.
  validates(:name, :presence => true, :uniqueness => {:scope => :user_id})
  
  ##############################################################################
  belongs_to(:user)   # Allows you to access a user:   car.user
  has_many(:refuels)  # Gives you an array of refuels: car.refuels
end
