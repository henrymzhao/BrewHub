class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
<<<<<<< HEAD
      redirect_to '/login'
=======
      render 'login_error'
>>>>>>> 6a562bbe11f0fa79f991c26296b4c20d5d0ec83c
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
