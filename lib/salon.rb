class Salon
	attr_reader(:name, :id)

	define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_salons = DB.exec("SELECT * FROM salons;")
      salons = []
      returned_salons.each() do |salon|
        name = salon.fetch("name")
        id = salon.fetch("id").to_i()
        salons.push(Salon.new({:name => name, :id => id}))
      end
      salons
    end
end