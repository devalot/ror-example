class CarsController < ApplicationController
  
  ##############################################################################
  # Load all cars for the current user.  Rails automatically renders
  # the app/views/cars/index.html.erb file.
  def index
    @cars = current_user.cars.order(:name)
  end
end
