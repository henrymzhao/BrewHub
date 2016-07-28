class SessionsController < ApplicationController

  #create a user session - this is for user creation, login, and authentication
  def create
    user = User.find_by_email(params[:email])
    #if the user is banned, well, they can't log in.  Not much else to say.
    if user && user.banned == false && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      render 'login_error'
    end
  end

  #facebook or google session
  def createfb
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if user && user.banned == false
      session[:user_id] = user.id
      redirect_to '/', :notice => "Signed in!"
    else
      render 'login_error'
    end
  end

  #if a user is destroyed... DESTROY THEM! and send them to login.
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
