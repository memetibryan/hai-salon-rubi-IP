class Salon < ActiveRecord::Base
	has_many(:clients)

	#Active Record Validations making sure the form is not submitted blank
	validates(:name, :presence => true)
end