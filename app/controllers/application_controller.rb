class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  #determine if a user exists within the session.  If so, log them in.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #If there is an anomaly with login, redirect back to the login page.
  def authorize
    redirect_to '/login' unless current_user
  end

  def groups
    @allGroups = Group.all
  end
end
