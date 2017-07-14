class Client
	attr_reader(:description, :salon_id)

	define_method(:initialize) do |attributes|
      @description = attributes.fetch(:description)
      @salon_id = attributes.fetch(:salon_id)
    end

    define_singleton_method(:all) do
      returned_clients = DB.exec("SELECT * FROM clients;")
      clients = []
      returned_clients.each() do |client|
        description = client.fetch("description")
        salon_id = client.fetch("salon_id").to_i() # The information comes out of the database as a string.
        clients.push(Client.new({:description => description, :salon_id => salon_id}))
      end
      clients
    end

    define_method(:save) do
      DB.exec("INSERT INTO clients (description, salon_id) VALUES ('#{@description}', #{@salon_id});")
    end
end