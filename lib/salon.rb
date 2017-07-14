class Salon < ActiveRecord::Base
	has_many(:clients) #creating one to many relationship

	#Active Record Validations making sure the form is not submitted blank
	validates(:name, :presence => true)
end