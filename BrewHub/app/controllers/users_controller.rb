class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user }
        #format.json { render :show, status: :created, location: @user }
        session[:user_id] = @user.id
        #redirect_to '/'
        format.html { redirect_to '/' }
      else
        #format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
        #redirect_to '/signup'
        format.html { redirect_to '/signup' }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation)
    end

end
