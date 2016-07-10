class Brewery < ActiveRecord::Base
    has_many :beers
    #attr_acessible :address, :latitude, :longitude
    #geocoded_by :address
    #after_validation :geocode
end