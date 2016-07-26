class SocialController < ApplicationController
  def meetup
    #this is a functionality for organizing a group of users.
    #it should get the user location on access and store it.
    @user = current_user
    @user.update_attributes(lat: request.location.latitude, lon: request.location.longitude)
    @user.save
  end

  def closest
    #this is functionality for finding the nearest brewery to a given location - this might be a page in page for Meetup?
    #user should perhaps be directed here if not logged in.
  end
end
