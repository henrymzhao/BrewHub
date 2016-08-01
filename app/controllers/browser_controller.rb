class BrowserController < ApplicationController
  #BrowserController is a hold-all for search functionality.  Currently, it holds the functionaliy to list beers, to list all pubs in British Columbia,
  #to show the API details of individual pubs, and to use back-up API keys if the first API key's requests have been exhausted.
  #Obviously, in a working environment, we would be paying for the full BreweryDB functionality.  However, since this is a student project, we just have a bunch of free keys.

  #a placeholder for now, will in the future be a page to more easily add beers and breweries.
  def new
    @browser = Browser.new
  end

  def styles
    #separate beers into styles - a testing page for now.
    @allbeers = Beer.all
    @allstyles = Style.all.order("name ASC")

    @allbreweries = Brewery.all
  end

  def showLoaded
    @allbeers = Beer.all.order("name ASC")
    @breweries = Brewery.all.order("name ASC")
  end

  def load(pc)
    #brewery_db = tryAll()#in theory we don't need this anymore -- nevermind it's needed for styles...should be fixed later

    #pc = request.location.province

    #if (pc == "")
    #  pc = "British Columbia"
    #end


    #this is where we read in the API data and store it in our database.
    #@styles = brewery_db.styles.all()

    ##We need to load styles only if we have none since we load all of them
    if Style.count == 0
      @styles = tryStyles()

      @styles.each do |s|
        @oppa = Style.new(style_id: s.id,
                          name: s.name.titleize,
                          description: s.description,
                          ibuMin: s.ibuMin,
                          ibuMax: s.ibuMax,
                          abvMin: s.abvMin,
                          abvMax: s.abvMax,
                          srmMin: s.srmMin,
                          srmMax: s.srmMax)
        @oppa.save!
      end
    end

    #@pubs = brewery_db.locations.all(region: pc)
    @pubs = tryBrewery(pc)

    @pubs.each do |p|

      begin
        p.brewery.images.medium.blank?
        @brewery = Brewery.new(brewery_id: p.id,
                            name: p.brewery.name.titleize,
                            latitude: p.latitude,
                            longitude: p.longitude,
                            gpsLocation: (p.latitude).to_s + ", " + (p.longitude).to_s,
                            address: p.street_address,
                            province: p.region,
                            locality: p.locality,
                            description: p.brewery.description,
                            imgUrl: p.brewery.images.medium,
                            website: p.brewery.website,
                            loc: pc)
      rescue
        @brewery = Brewery.new(brewery_id: p.id,
                            name: p.brewery.name.titleize,
                            latitude: p.latitude,
                            longitude: p.longitude,
                            gpsLocation: (p.latitude).to_s + ", " + (p.longitude).to_s,
                            address: p.street_address,
                            locality: p.locality,
                            description: p.brewery.description,
                            #imgUrl: p.brewery.images.medium,
                            website: p.brewery.website,
                            loc: pc)
      end

      @brewery.save!

      #@beers = brewery_db.brewery(p.id).beers#theoretically we also don't need this anymore
      @beers = tryBeer(p.id)

#     @beer = @brewery.beers.create
      unless @beers.nil?
        @beers.each do |b|
          @thisBeerRightHere = @brewery.beers.create(beer_id: b.id,
                                        name: b.name.titleize,
                                        ibu: b.ibu,
                                        abv: b.abv,
                                        style_id: b.styleId,
                                        srmId: b.srmId,
                                        loc: pc)
          @thisBeerRightHere.save!
        end
      end
    end
  end

  #a page for listing information about beers.  Currently, this controller is of no consequence to the actual page.
  def beers
    #For the time being at least nothing in beers is loaded from DBs

    #brewery_db = tryAll()

    #@beers = brewery_db.beers.all(withBreweries: 'Y')
    #@beers = brewery_db.beers.all(abv: '5.5')
    ##We need to localise this
    #@beers = brewery_db.beers.all(withBreweries: 'Y')

    #@nonOrgbeers = brewery_db.beers.all(availableId:'1')

  end

  #a page for showing all breweries in an area.
  def pubs
    #find a working API key within tryAll
    ##brewery_db = tryAll()

    #example API code for reference purposes
    #@pubs = brewery_db.brewery('AAj4GG').all()
    #pc = request.location.province



    #get the user's province/state.  If blank, default to British Columbia.  This should only happen when being run locally.

    pc = ""
    pc = request.location.province
    if (pc == "")
      pc = "British Columbia"
    end
    #@pc = ""

    #begin
    #  @pc = request.location.province
    #rescue
    #  if (@pc == "")
    #    @pc = "British Columbia"
    #  end
    
    
    #pc= "Alberta"
    #pc = "British Columbia"


    #grab all breweries from the user'slocation
    #pubs = Brewery.where(:province == pc).order("name ASC")
    #@pubs = Brewery.near([49.277577, -122.913970], 6)
    #Brewery.geocoded
    
    @maxPubDist = 12
    
    
    @pubs = Brewery.where("loc = ?", pc).order("name ASC")
    if @pubs.count == 0
        load(pc)
    end
    #@pubs = Brewery.where("loc = ?", pc).order("name ASC")
    
    
    #COMMENT OUT WHEN TESING LOCALLY - UNCOMMENT WHEN PUSHING TO TEST ON HEROKU.
    #@pubs = Brewery.near([request.location.latitude, request.location.longitude], @maxPubDist, :units => :km).order("name ASC")


    #this location is faculty of applied sciences at SFU.
    @pubs = Brewery.near([49.277577, -122.913970], @maxPubDist, :units => :km)
    
    
    #@pubs = Brewery.where("loc = ?", pc).order("name ASC")
    #if @pubs.count == 0
      #load(pc)
      #@pubs = Brewery.where("loc = ?", pc).order("name ASC")
    #end



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
    #brewery_db = tryAll()
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


  def style

     @pc = ""

    @pc = request.location.province
    if (@pc == "")
      @pc = "British Columbia"
    end
    @styleBeers = []

    #@pub = brewery_db.brewery(params[:id]).all
    #find this particular style.
    @style = Style.find(params[:id])

    #A list of all beers associated with this style.
    @allStyleBeers = Beer.where(:style_id => @style.style_id)


    #filter down to user's location.

    #find breweries associated with these styles.
    @allStyleBeers.each do |asb|

      #find the associated Brewery so that we can determine it's location.
      @asbBreweries = Brewery.where(:id => asb.brewery_id)

      @asbBreweries.each do |asbB|
        @thisBrewery = asbB
      end

      #if the brewery we just found is in the user's province, add it to StyleBeers.
      if @pc.to_s.titleize.strip == @thisBrewery.province.to_s.titleize.strip
        @styleBeers << asb
      else
        @temp = "ABC"
      end

    end
    
    
    render :layout => 'blank'

  end

  #here we deal with our API keys - we need a whole bunch for testing purposes, so that we don't run into a request limit.
#  def tryAll
#    #a bunch of nested try/catch blocks, basically, along with code to validate connection. keys are stored in the environment.
#    begin
#      brewery_db = BreweryDB::Client.new do |config|
#        config.api_key = API_KEY
#      end
#      @pubs = brewery_db.brewery('AAj4GG').beers
#    rescue
#      begin
#        brewery_db = BreweryDB::Client.new do |config|
#          config.api_key = BACKUP_API_KEY_1
#        end
#        @pubs = brewery_db.brewery('AAj4GG').beers
#      rescue
#        begin
#          brewery_db = BreweryDB::Client.new do |config|
#            config.api_key = BACKUP_API_KEY_2
#          end
#          @pubs = brewery_db.brewery('AAj4GG').beers
#        rescue
#          begin
#            brewery_db = BreweryDB::Client.new do |config|
#              config.api_key = BACKUP_API_KEY_3
#            end
#            @pubs = brewery_db.brewery('AAj4GG').beers
#          rescue
#            begin
#              brewery_db = BreweryDB::Client.new do |config|
#                config.api_key = BACKUP_API_KEY_4
#              end
#              @pubs = brewery_db.brewery('AAj4GG').beers
#            rescue
#              begin
#                brewery_db = BreweryDB::Client.new do |config|
#                  config.api_key = BACKUP_API_KEY_5
#                end
#                @pubs = brewery_db.brewery('AAj4GG').beers
#              rescue
#                begin
#                  brewery_db = BreweryDB::Client.new do |config|
#                    config.api_key = BACKUP_API_KEY_6
#                  end
#                  @pubs = brewery_db.brewery('AAj4GG').beers
#                rescue
#                  brewery_db = BreweryDB::Client.new do |config|
#                    config.api_key = BACKUP_API_KEY_7
#                  end
#                end
#              end
#            end
#          end
#        end
#      end
#    end
#    #Return the working key
#    return brewery_db
#  end


  def tryBrewery(provLoc)
    #a bunch of nested try/catch blocks, basically, along with code to validate connection. keys are stored in the environment.
    begin
      brewery_db = BreweryDB::Client.new do |config|
        config.api_key = API_KEY
      end
      pubs = brewery_db.locations.all(region: provLoc)
    rescue
      begin
        brewery_db = BreweryDB::Client.new do |config|
          config.api_key = BACKUP_API_KEY_1
        end
        pubs = brewery_db.locations.all(region: provLoc)
      rescue
        begin
          brewery_db = BreweryDB::Client.new do |config|
            config.api_key = BACKUP_API_KEY_2
          end
          pubs = brewery_db.locations.all(region: provLoc)
        rescue
          begin
            brewery_db = BreweryDB::Client.new do |config|
              config.api_key = BACKUP_API_KEY_3
            end
            pubs = brewery_db.locations.all(region: provLoc)
          rescue
            begin
              brewery_db = BreweryDB::Client.new do |config|
                config.api_key = BACKUP_API_KEY_4
              end
              pubs = brewery_db.locations.all(region: provLoc)
            rescue
              begin
                brewery_db = BreweryDB::Client.new do |config|
                  config.api_key = BACKUP_API_KEY_5
                end
                pubs = brewery_db.locations.all(region: provLoc)
              rescue
                begin
                  brewery_db = BreweryDB::Client.new do |config|
                    config.api_key = BACKUP_API_KEY_6
                  end
                  pubs = brewery_db.locations.all(region: provLoc)
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
    return pubs
  end

  def tryBeer(brewID)
    #a bunch of nested try/catch blocks, basically, along with code to validate connection. keys are stored in the environment.
    begin
      brewery_db = BreweryDB::Client.new do |config|
        config.api_key = API_KEY
      end
      beers = brewery_db.brewery(brewID).beers
    rescue
      begin
        brewery_db = BreweryDB::Client.new do |config|
          config.api_key = BACKUP_API_KEY_1
        end
        beers = brewery_db.brewery(brewID).beers
      rescue
        begin
          brewery_db = BreweryDB::Client.new do |config|
            config.api_key = BACKUP_API_KEY_2
          end
          beers = brewery_db.brewery(brewID).beers
        rescue
          begin
            brewery_db = BreweryDB::Client.new do |config|
              config.api_key = BACKUP_API_KEY_3
            end
            beers = brewery_db.brewery(brewID).beers
          rescue
            begin
              brewery_db = BreweryDB::Client.new do |config|
                config.api_key = BACKUP_API_KEY_4
              end
              beers = brewery_db.brewery(brewID).beers
            rescue
              begin
                brewery_db = BreweryDB::Client.new do |config|
                  config.api_key = BACKUP_API_KEY_5
                end
                beers = brewery_db.brewery(brewID).beers
              rescue
                begin
                  brewery_db = BreweryDB::Client.new do |config|
                    config.api_key = BACKUP_API_KEY_6
                  end
                  beers = brewery_db.brewery(brewID).beers
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
    return beers
  end

  def tryStyles
    #a bunch of nested try/catch blocks, basically, along with code to validate connection. keys are stored in the environment.
    begin
      brewery_db = BreweryDB::Client.new do |config|
        config.api_key = API_KEY
      end
      styles = brewery_db.styles.all()
    rescue
      begin
        brewery_db = BreweryDB::Client.new do |config|
          config.api_key = BACKUP_API_KEY_1
        end
        styles = brewery_db.styles.all()
      rescue
        begin
          brewery_db = BreweryDB::Client.new do |config|
            config.api_key = BACKUP_API_KEY_2
          end
          styles = brewery_db.styles.all()
        rescue
          begin
            brewery_db = BreweryDB::Client.new do |config|
              config.api_key = BACKUP_API_KEY_3
            end
            styles = brewery_db.styles.all()
          rescue
            begin
              brewery_db = BreweryDB::Client.new do |config|
                config.api_key = BACKUP_API_KEY_4
              end
              styles = brewery_db.styles.all()
            rescue
              begin
                brewery_db = BreweryDB::Client.new do |config|
                  config.api_key = BACKUP_API_KEY_5
                end
                styles = brewery_db.styles.all()
              rescue
                begin
                  brewery_db = BreweryDB::Client.new do |config|
                    config.api_key = BACKUP_API_KEY_6
                  end
                  styles = brewery_db.styles.all()
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
    return styles
  end

end
