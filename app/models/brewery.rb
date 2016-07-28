class Brewery < ActiveRecord::Base
  has_many :beers
  validates_uniqueness_of :brewery_id
end
