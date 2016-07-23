class BrowserController < ApplicationController
  #BrowserController is a hold-all for search functionality.  Currently, it holds the functionaliy to list beers, to list all pubs in British Columbia,
  #to show the API details of individual pubs, and to use back-up API keys if the first API key's requests have been exhausted.
  #Obviously, in a working environment, we would be paying for the full BreweryDB functionality.  However, since this is a student project, we just have a bunch of free keys.
  
  #a placeholder for now, will in the future be a page to more easily add beers and breweries.
  def new
    @browser = Browser.new
  end
  
  def showLoaded
    @allbeers = Beer.all
    @breweries = Brewery.all
  end
  
  def load
    brewery_db = tryAll()
    
    pc = request.location.province
    if (pc == "")
      pc = "British Columbia"
    end
    
    #locality, description, imgUrl
    
    @pubs = brewery_db.locations.all(region: pc)
    
    @pubs.each do |p|
      
      begin
        p.brewery.images.medium.blank?
        @brewery = Brewery.new(brewery_id: p.id,
                             name: p.brewery.name,
                             latitude: p.latitude,
                             longitude: p.longitude,
                             gpsLocation: (p.latitude).to_s + ", " + (p.longitude).to_s,
                             address: p.street_address,
                             locality: p.locality,
                             description: p.brewery.description,
                             imgUrl: p.brewery.images.medium,
                            website: p.brewery.website)
        rescue
          @brewery = Brewery.new(brewery_id: p.id,
                             name: p.brewery.name,
                             latitude: p.latitude,
                             longitude: p.longitude,
                             gpsLocation: (p.latitude).to_s + ", " + (p.longitude).to_s,
                             address: p.street_address,
                             locality: p.locality,
                             description: p.brewery.description,
                             #imgUrl: p.brewery.images.medium,
                            website: p.brewery.website)
      end
      
    @brewery.save!
    
    @beers = brewery_db.brewery(p.id).beers
    
#    @beer = @brewery.beers.create
      @beers.each do |b|
        @thisBeerRightHere = @brewery.beers.create(beer_id: b.id,
                                      name: b.name,
                                      ibu: b.ibu,
                                      abv: b.abv,
                                      styleId: b.styleId,
                                      srmId: b.srmId)
        @thisBeerRightHere.save!
      end
    end
  end

  #a page for listing information about beers.  Currently, this controller is of no consequence to the actual page.
  def beers
    brewery_db = tryAll()

    #@beers = brewery_db.beers.all(withBreweries: 'Y')
    #@beers = brewery_db.beers.all(abv: '5.5')
    ##We need to localise this
    #@beers = brewery_db.beers.all(withBreweries: 'Y')

    @nonOrgbeers = brewery_db.beers.all(availableId:'1')
    
  end

  #a page for showing all breweries in an area.
  def pubs
    #find a working API key within tryAll
    brewery_db = tryAll()

    #example API code for reference purposes
    #@pubs = brewery_db.brewery('AAj4GG').all()
    #pc = request.location.province
    
    @pubs = Brewery.all
    
    #get the user's province/state.  If blank, default to British Columbia.  This should only happen when being run locally.
    pc = ""
    
    begin
      pc = request.location.province
    rescue
      if (pc == "")
        pc = "British Columbia"
      end
    end
    
    #grab all breweries from the user'slocation

    
    
    
    #old code for grabbing all bc breweries, kept for reference purposes.
    #@breweries1 = brewery_db.breweries.all(ids: 'DqlySI, GSkOGp,yagN3u,zC8X6x,Xr0G6p,AAj4GG,aywDqA,gvFuE2,SxnUb2,nVB9Cq')
    #@breweries2 = brewery_db.breweries.all(ids: 'dZ0mKT,Bk34Go,iorTHl,yGsalR,supFO9,RNHfY1,hwiUzY,aabOus,xuSuqz,aEBj0Q')
    #@breweries3 = brewery_db.breweries.all(ids: 'MOpp7e,xeiOQd,VvFIVD,0fVPvA,jtBUsv,jOPm0a,XhwArB,q4luwR,bVrLGO,SvtdGo')
    #@breweries4 = brewery_db.breweries.all(ids: 'iNukkU,kYguo5,bSzuQk,oZ1O3I,wx3Zxa,Dl36n0,LGSXeN,2vIPMI,Lx9mc0,SmLlGS')
    #@breweries5 = brewery_db.breweries.all(ids: 'Z99f7V,jXi6nH,NSg3y6,Y8edrP,vX1ujj,ouUm8w,BMC26E,VV0cFh,MsPixW,32gsol')
    #@breweries6 = brewery_db.breweries.all(ids: 'LKzaHC,bArjvS,LVjHK1,erABL9,j1Gm7l,q5xjyu,UBPqyt,VJ56AP')
    #@allbreweries = [@breweries1, @breweries2, @breweries3, @breweries4, @breweries5, @breweries6]
  end

  #an individual brewery - pass in the appropriate information to the page as a parameter.
  def pub
    brewery_db = tryAll()
    #@pub = brewery_db.brewery(params[:id]).all
    @pub = Brewery.find(params[:id])
    @pubBeers = Beer.where(:brewery_id => @pub.id)
    
#    @breweries.each do |b|
#    %>
#<p><%=b.name%>, <%=b.id%>, <%=b.brew_id%>, <%=b.gpsLocation%></p>
#<%
#  @brewerysBeers = Beer.where(b.brew_id == :beer_brewery_id)
#  @brewerysBeers.each do |bb| %>
#    <p><%=bb.name%></p>
#<%end
#end%>
    
    
    #@pub = brewery_db.locations.find(params[:id])
    render :layout => 'blank'
    
    
    
    #@brewery = Brewery.new(name: @pub.brewery.name,
     #                      latitude: @pub.latitude,
      #                     longitude: @pub.longitude,
       #                    gpsLocation: (@pub.latitude).to_s + ", " + (@pub.longitude).to_s,
        #                   address: @pub.street_address,
         #                 website: @pub.brewery.website,
          #                 hoursOfOperation: @pub.hoursOfOperation)
    
    
#    if (!@brewery.save!)
 #     flash[:notice] = @brewery.errors
  #  end
    
    
    
    
    
  end
  
  #here we deal with our API keys - we need a whole bunch for testing purposes, so that we don't run into a request limit.
  def tryAll
    #a bunch of nested try/catch blocks, basically, along with code to validate connection. keys are stored in the environment.
    begin
      brewery_db = BreweryDB::Client.new do |config|
        config.api_key = API_KEY
      end
      @pubs = brewery_db.brewery('AAj4GG').beers
    rescue
      begin
        brewery_db = BreweryDB::Client.new do |config|
          config.api_key = BACKUP_API_KEY_1
        end
        @pubs = brewery_db.brewery('AAj4GG').beers
      rescue
        begin
          brewery_db = BreweryDB::Client.new do |config|
            config.api_key = BACKUP_API_KEY_2
          end
          @pubs = brewery_db.brewery('AAj4GG').beers
        rescue
          begin
            brewery_db = BreweryDB::Client.new do |config|
              config.api_key = BACKUP_API_KEY_3
            end
            @pubs = brewery_db.brewery('AAj4GG').beers
          rescue
            begin
              brewery_db = BreweryDB::Client.new do |config|
                config.api_key = BACKUP_API_KEY_4
              end
              @pubs = brewery_db.brewery('AAj4GG').beers
            rescue
              begin
                brewery_db = BreweryDB::Client.new do |config|
                  config.api_key = BACKUP_API_KEY_5
                end
                @pubs = brewery_db.brewery('AAj4GG').beers
              rescue
                begin
                  brewery_db = BreweryDB::Client.new do |config|
                    config.api_key = BACKUP_API_KEY_6
                  end
                  @pubs = brewery_db.brewery('AAj4GG').beers
                rescue
                  brewery_db = BreweryDB::Client.new do |config|
                    config.api_key = BACKUP_API_KEY_7
                  end
                end
              end
            end
          end
        end
      end
    end
    #Return the working key
    return brewery_db
  end
end
