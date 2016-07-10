class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end
  
  #https://github.com/theverything/four04kids/blob/master/app/controllers/application_controller.rb#L8
#  def location
#    if params[:location].blank?
#      if Rails.env.test? || Rails.env.development?
#        @location ||= Geocoder.search("207.23.205.194").first
#        #this is the cornerstone starbucks location.
#      else
#        #get the user's location if we're not in test.
#        @location ||= request.location
#      end
#    else
#      #then we have the location already.
#      params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
#      @location ||= Geocoder.search(params[:location]).first
#      allowed = [:latitude, :longitude, :address, :city]
#      puts @location.methods
#      @location
#    end    
#  end
end
