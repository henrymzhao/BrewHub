class Group < ActiveRecord::Base
	has_many :users

	validates :name, presence: true, length:{maximum: 50},
                    uniqueness: {case_sensitive:false }

end
