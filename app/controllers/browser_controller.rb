class BrowserController < ApplicationController

  def new
    @browser = Browser.new
    @beer = Beer.new
  end

  def beers
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    #@beers = brewery_db.beers.all(withBreweries: 'Y')
    @beers = brewery_db.beers.all(abv: '5.5')
  end

  def pubs
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end

    #@pubs = brewery_db.brewery('AAj4GG').all()
    #@pubs = brewery_db.breweries().location
    @pubs = brewery_db.locations.all(region: 'british columbia')
  end

  def pub
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    #@pub = brewery_db.brewery(params[:id]).all
    #@pub = brewery_db.breweries.find(params[:id])
    @pub = brewery_db.locations.find(params[:id])
  end
end
