class CarsController < ApplicationController
  
  ##############################################################################
  # The following class method tells Rails what formats we can respond
  # with.  This is necessary to use the `respond_with` helper later.
  respond_to(:html, :xml, :json)

  ##############################################################################
  # Load all cars for the current user.  Rails automatically renders
  # the app/views/cars/index.html.erb file.
  def index
    @cars = current_user.cars.order(:name)
    respond_with(@cars)
  end
  
  ##############################################################################
  # Normally, if a model had enough information to display on a
  # dedicated page you would do so here in the show action.  Since a
  # car only has a name it doesn't make much sense to show that by
  # itself, so we'll just redirect to the index action.
  def show
    redirect_to(cars_path)
  end
  
  ##############################################################################
  # Using `respond_with` below will automatically render
  # app/views/cars/new.html.erb if the current request wants HTML, or
  # it can render XML or JSON if that's what the request calls for.
  def new
    @car = current_user.cars.new
    respond_with(@car)
  end
  
  ##############################################################################
  def create
    @car = current_user.cars.create(params[:car])
    respond_with(@car)
  end
  
  ##############################################################################
  def edit
    @car = current_user.cars.find(params[:id])
    respond_with(@car)
  end

  ##############################################################################
  def update
    @car = current_user.cars.find(params[:id])
    @car.update_attributes(params[:car])
    respond_with(@car)
  end
    
  ##############################################################################
  def destroy
    @car = current_user.cars.find(params[:id])
    @car.destroy
    respond_with(@car)
  end
end
