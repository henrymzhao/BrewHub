class Beer < ActiveRecord::Base
    belongs_to :brewery
    validates_uniqueness_of :beer_id
end
