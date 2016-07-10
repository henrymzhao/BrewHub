class BrowserController < ApplicationController

  def new
    @browser = Browser.new
    @beer = Beer.new
  end

  def beers
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

    #@beers = brewery_db.beers.all(withBreweries: 'Y')
    #@beers = brewery_db.beers.all(abv: '5.5')
    ##We need to localise this
    #@beers = brewery_db.beers.all(withBreweries: 'Y')

    @beers = brewery_db.beers.all(abv: '5.5')


  end

  def pubs
    #find a working API key
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

    #@pubs = brewery_db.brewery('AAj4GG').all()
    #@pubs = brewery_db.breweries().location
    @pubs = brewery_db.locations.all(region: 'british columbia')

    #@breweries1 = brewery_db.breweries.all(ids: 'DqlySI, GSkOGp,yagN3u,zC8X6x,Xr0G6p,AAj4GG,aywDqA,gvFuE2,SxnUb2,nVB9Cq')
    #@breweries2 = brewery_db.breweries.all(ids: 'dZ0mKT,Bk34Go,iorTHl,yGsalR,supFO9,RNHfY1,hwiUzY,aabOus,xuSuqz,aEBj0Q')
    #@breweries3 = brewery_db.breweries.all(ids: 'MOpp7e,xeiOQd,VvFIVD,0fVPvA,jtBUsv,jOPm0a,XhwArB,q4luwR,bVrLGO,SvtdGo')
    #@breweries4 = brewery_db.breweries.all(ids: 'iNukkU,kYguo5,bSzuQk,oZ1O3I,wx3Zxa,Dl36n0,LGSXeN,2vIPMI,Lx9mc0,SmLlGS')
    #@breweries5 = brewery_db.breweries.all(ids: 'Z99f7V,jXi6nH,NSg3y6,Y8edrP,vX1ujj,ouUm8w,BMC26E,VV0cFh,MsPixW,32gsol')
    #@breweries6 = brewery_db.breweries.all(ids: 'LKzaHC,bArjvS,LVjHK1,erABL9,j1Gm7l,q5xjyu,UBPqyt,VJ56AP')

    #@allbreweries = [@breweries1, @breweries2, @breweries3, @breweries4, @breweries5, @breweries6]
  end

  def pub
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = BACKUP_API_KEY_6
    end#This needs to be "try catched"
    #@pub = brewery_db.brewery(params[:id]).all
    @pub = brewery_db.locations.find(params[:id])
  end
end
