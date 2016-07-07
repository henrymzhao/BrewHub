class BrowserController < ApplicationController

  def new
    @browser = Browser.new
    @beer = Beer.new
  end

  def beers
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    @beers = brewery_db.beers.all(withBreweries: 'Y')
  end

  def pubs
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    
    
    
    @pubs = brewery_db.brewery('AAj4GG').beers()
  end
end
