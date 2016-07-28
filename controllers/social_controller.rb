class SocialController < ApplicationController
  def meetup
    #this is a functionality for organizing a group of users.
    #it should get the user location on access and store it.
    @user = current_user
    @user.update_attributes(lat: request.location.latitude, lon: request.location.longitude)
    @user.save
    centralize
  end

  def closest
    #this is functionality for finding the nearest brewery to a given location - this might be a page in page for Meetup?
    #user should perhaps be directed here if not logged in.
  end
  
  #should eventually take in a user as an 'argument'
  #then will query this group for all users with the user's same 'group value'.
  def centralize
    #testing with brewery location data for now.
    @breweries = Brewery.where(:locality => "Surrey")
    
    
    @centralLat = 0
    
    @breweries.each do |b|
      @centralLat += b.latitude.to_f
    end
    
    @centralLat = @centralLat / @breweries.count
    
  end
end
