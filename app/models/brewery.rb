class Brewery < ActiveRecord::Base
  has_many :beers
  validates_uniqueness_of :brewery_id
  geocoded_by :ip_address
  #dont uncomment after_validation - i dont think we need this, since we're already populating lat/lng ourselves.  it causes crashes, endless crashes.
  #after_validation :geocode
end
