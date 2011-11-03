class ApplicationController < ActionController::Base
  
  ##############################################################################
  # Enable forgery protection. See http://en.wikipedia.org/wiki/CSRF
  protect_from_forgery
  
  ##############################################################################
  private
  
  ##############################################################################
  # Return the logged in user, if there is one.  This method, and all
  # others defined in this file, are available to all of the other
  # controllers due to inheritance.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  ##############################################################################
  # Returns true if a user is logged in.
  def logged_in?
    !current_user.blank?
  end
  
  ##############################################################################
  # Export the `current_user` and `logged_in?` methods to the views.
  helper_method(:current_user, :logged_in?)
  
  ##############################################################################
  # This method will be used as a before filter so we can force a
  # redirect if the current user hasn't logged in yet.
  def require_authentication
    redirect_to(login_path) unless logged_in?
  end
  
  ##############################################################################
  # By placing the filter here, in the ApplicationController, all
  # other controllers will inherit it.  That means all other
  # controllers in this application require a user to be logged in, or
  # they get redirected to the login form.  Take a look at the
  # sessions controller for information about how to disabled this
  # global before filter.
  before_filter(:require_authentication)
end
