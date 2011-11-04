class RefuelsController < ApplicationController
  
  ##############################################################################
  # Establish a filter that will run before any of the actions in this
  # controller run.  Its job will be to create a `@car` instance
  # variable that we can use to access refuel objects.  The
  # `fetch_car` method can be found at the bottom of this file.
  before_filter(:fetch_car)

  ##############################################################################
  # See the note in cars_controller.rb
  respond_to(:html, :xml, :json)

  ##############################################################################
  def index
    @refuels = @car.refuels.order('refueled_at DESC')
    respond_with(@car, @refuels) # need @car because this is a nested resource 
  end
  
  ##############################################################################
  def show
    @refuel = @car.refuels.find(params[:id])
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  def new
    @refuel = @car.refuels.new
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  def create
    @refuel = @car.refuels.create(params[:refuel])
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  def edit
    @refuel = @car.refuels.find(params[:id])
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  def update
    @refuel = @car.refuels.find(params[:id])
    @refuel.update_attributes(params[:refuel])
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  def destroy
    @refuel = @car.refuels.find(params[:id])
    @refuel.destroy
    respond_with(@car, @refuel)
  end
  
  ##############################################################################
  private
  
  ##############################################################################
  # Since this controller is a nested resource under the cars
  # resource, all invocations will include a `:car_id` parameter to
  # tell us which car we are working with.
  def fetch_car
    @car = current_user.cars.find(params[:car_id])
  end
end
