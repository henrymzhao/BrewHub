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
  def centralize(gid)
    #testing with brewery location data for now.
    breweries = Brewery.all

    allUsers = User.all
    centralLat = 0.0
    centralLon = 0.0
    groupSize = 0
    allUsers.each do |u|
      u.group_id.each do |b|
        if b == gid
          # u.lat = request.location.latitude
          # u.lon = request.location.longitude
          centralLat += u.lat.to_f
          centralLon += u.lon.to_f
          groupSize += 1
        end
      end
    end

    centralLat = centralLat / groupSize
    centralLon = centralLon / groupSize

    #centralLat = 49.277577
    #centralLon = -122.913970
    #@nearBreweries = Brewery.near([centralLat.to_f, centralLon.to_f], 25, :units => :km)
    #@nearestID = 999#

    #@nearBreweries.each do |nb|
    #  @nearestID = nb.id
    #end

    #curGroup = Group.find_by(id: gid)
    #curGroup.update(brewery_id: @nearestID)#

    #curGroup.save!
#
#    @avgLat = centralLat
#    @avgLon = centralLon
    return centralLat, centralLon
    #Right here we need to put the code to get a central brewery selected
  #  @pubs = Brewery.near([centralLat, centralLon], 10, :units => :km).order("name ASC")
  #  if request.location.latitude == 0 && request.location.longitude == 0
  #    @pubs = Brewery.near([49.277577, -122.913970], 10, :units => :km)
    #end
  end

  def create
    params.permit!
    @group = Group.new(params[:groups])
      if @group.save
        flash[:notice] = "Group Created, user is a member in it"
        current_user.group_id.push(@group.id)
        @current_user.save
        redirect_to '/group/' + @group.id.to_s
      else
        flash[:notice] = "Group Created, user not in it"#Would this ever be seen?
        # current_user.group_id = @group.group_id
        redirect_to '/groups'
      end
  end

  #def index
#    @groups = Group.all
#  end

#  def show
#    @group = Group.find(params[:id])
#  end

  def new#needed??????
    @group = Group.new
  end

  def groups
    @allGroups = Group.all
  end

  def group
    @group = Group.find(params[:id])
    @allUsers = User.all
    @centralLat, @centralLon = centralize(@group.id)
  end

  def request_member
    params.permit!
    @user = User.find_by_email(params[:member][:name])
    unless @user
      @message = "Couldn't find a user with that email"
      return
    end
    @user.pending_group_id.push(params[:gid].to_i)
    @user.save
    @message = "Successfully found the user with that email!"
  end

  def remove_self
    current_user.group_id.delete(params[:id].to_f)#.to.f is necassary for num conversion from the string in the URL
    current_user.save
    redirect_to '/groups'
  end

  def accept_membership
    accepted_id = current_user.pending_group_id.delete(params[:id].to_f)
    if accepted_id >= 0
      current_user.group_id.push(accepted_id)
    end
    current_user.save
    redirect_to '/groups'
  end

  def deny_membership
    current_user.pending_group_id.delete(params[:id].to_f)
    current_user.save
    redirect_to '/groups'
  end

  def set_meetup
    @group = Group.find(params[:gid])
    @group.brewery_id = params[:bid]
    @group.save
    render :text => "<script>parent.location.href='/group/" + @group.id.to_s + "';</script>"
  end
end
