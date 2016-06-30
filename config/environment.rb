API_KEY = '209c8e0eec82b6f0ce64e8bc51b5385b'

brewery_db = BreweryDB::Client.new do |config|
  config.api_key = API_KEY
end


# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
