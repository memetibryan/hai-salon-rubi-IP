class Salon < ActiveRecord::Base
	has_many(:clients) #creating one to many relationship

	#Active Record Validations making sure the form is not submitted blank
	validates(:name, :presence => true)

	#validates the number of characters input by the user
	validates(:name, {:presence => true, :length => { :maximum => 19 }})

	#changes the input to Title_Case
	before_save(:titlecase_name)

private

    define_method(:titlecase_name) do
      self.name = (name().titlecase())
    end
end