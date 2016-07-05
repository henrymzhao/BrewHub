class BrowserController < ApplicationController

  def beers
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    @beers = brewery_db.beers.all(abv: '5.5')
  end

  def pubs
    brewery_db = BreweryDB::Client.new do |config|
      config.api_key = API_KEY
    end
    @pubs = brewery_db.breweries.all(name: "a*")
  end
end
