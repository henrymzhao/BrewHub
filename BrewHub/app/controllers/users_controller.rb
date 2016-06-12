class UsersController < ApplicationController
  def new#This is a user that is used for the filling out of the new user form
    @user = User.new
  end
  def create#This creates the actual user in the DB
    params.permit!
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Welcome to BrewHUB"
      flash[:color] = "valid"
    else
      flash[:notice] = "Something is invalid"
      flash[:color] = "invalid"
    end
    render "new"
  end
end
