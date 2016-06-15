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

  # def create
  #   @user = User.new(user_params)
  #    respond_to do |format|
  #     if @user.save
        
  #       #format.json { render :show, status: :created, location: @user }
  #       session[:user_id] = @user.id
  #       #redirect_to '/'
  #       # format.html { redirect_to 'index' }
  #       format.html { redirect_to '/users' }
  #     else
  #       format.html { render '/signup' }
  #       #format.json { render json: @user.errors, status: :unprocessable_entity }
  #       #redirect_to '/signup'
  #       # format.html { redirect_to '/signup' }
  #       # format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
def create
  @user = User.new(user_params)

  respond_to do |format|
    if @user.save
      # flash[:notice] = 'User was successfully created.'
      format.html { redirect_to "index"}
      # format.xml { render xml: @user, status: :created, location: @user }
    else
      format.html.none { render "new" }
      # format.xml { render xml: @user.errors, status: :unprocessable_entity }
    end
  end
end

  private
    def user_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation)
    end

end
