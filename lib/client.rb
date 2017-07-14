class Client < ActiveRecord::Base
	belongs_to(:salon) #creating one to many relationship
end