################################################################################
# To see a complete list of all routes use the following command:
#
#   rake routes
#
Example::Application.routes.draw do
  
  ##############################################################################
  # Create all the default routes for the cars controller.
  resources(:cars) do

    # Refuels is a nested resource, you have to get to them through
    # the cars resource.  This affects URLs and the URL generators.
    # After adding this try running `rake routes`.
    resources(:refuels)
  end
  
  ##############################################################################
  # Default and custom routes for sessions
  resources(:sessions)
  match('/login'  => 'sessions#new',     :as => :login)
  match('/logout' => 'sessions#destroy', :as => :logout)
  
  ##############################################################################
  # Route '/' to the cars controller.
  root(:to => 'cars#index')
end
