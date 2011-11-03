class SessionsController < ApplicationController
  
  ##############################################################################
  # We need to disable the `require_authentication` before filter that
  # was added in the ApplicationController otherwise when the user
  # tries to access the login form he/she will be redirected to the
  # login form (an infinite loop of redirects).
  skip_filter(:require_authentication)
  
  ##############################################################################
  # We don't need an index method for this controller, we we'll just
  # force the user to redirect to '/'.
  def index
    redirect_to(root_path)
  end
  
  ##############################################################################
  # The new method is where we can show the login form to the user.
  # Rails will automatically render the app/views/sessions/new.html.erb file.
  def new
  end
  
  ##############################################################################
  # The form in new.html.erb will post to this method.
  def create
    email, password = params[:user][:email], params[:user][:password]

    if user = User.authenticate(email, password)
      session[:user_id] = user.id
      redirect_to(root_url, :notice => 'Logged in!')
    else
      flash.now.alert = 'Invalid email address or password'
      render('new') # render new.html.erb
    end
  end
  
  ##############################################################################
  # The last method we need is `destroy` which we'll use to log the
  # current user out.
  def destroy
    session[:user_id] = nil
    redirect_to(root_path)
  end
end
