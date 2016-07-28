class Style < ActiveRecord::Base
  validates_uniqueness_of :style_id
end
