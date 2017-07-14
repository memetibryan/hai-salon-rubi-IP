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

    define_method(:save) do
      result = DB.exec("INSERT INTO salons (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_salon|
      self.name().==(another_salon.name()).&(self.id().==(another_salon.id()))
    end

    define_singleton_method(:find) do |id|
      found_salon = nil
      Salon.all().each() do |salon|
        if salon.id().==(id)
          found_salon = salon
        end
      end
      found_salon
    end
end