class Brewery < ActiveRecord::Base
  has_many :beers
  validates_uniqueness_of :brewery_id
  geocoded_by :ip_address
  #after_validation :geocode
end
