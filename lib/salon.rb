class Salon < ActiveRecord::Base
	has_many(:clients)
end