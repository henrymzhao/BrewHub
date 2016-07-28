class UsersController < ApplicationController

  #the typical user functionality is contained here, nothing too special.
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  #ban functionality exists - a simple t/f in the user attributes.
  def ban
    @user = User.find(params[:id])
    if !@user.banned
      @user.update_attribute(:banned,'t')
    else
      @user.update_attribute(:banned,'f')
    end
    @user.save
  end

  #a simple set of admin attributes.
  def admin
    @user = User.find(params[:id])
    if !@user.admin
      @user.update_attribute(:admin,'t')
    else
      @user.update_attribute(:admin,'f')
    end
    @user.save
  end

  #simple user creation
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
        #format.html { redirect_to '/signup' }
        format.html.none { render "new" }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.firstname = "example"
      user.lastname = "example"
      user.username = rand 10000000
      user.email = "#{user.username}@example.com"
      user.password = auth["uid"]
      user.password_confirmation = auth["uid"]
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.oauth_token = auth["credentials"]["token"]
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end

  private
    def user_params
      params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation, :banned, :admin, :provider, :uid)
    end

end
