class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.banned == false && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      render 'login_error'
    end
  end

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

  def destroy
    reset_session
    redirect_to '/login'
  end


end
