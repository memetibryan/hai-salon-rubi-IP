require('sinatra')
  require('sinatra/reloader')
  also_reload('lib/**/*.rb')
  require("pg")
  #database
  require("sinatra/activerecord")
  #database and alsways require before the classes using it
  require('./lib/salon')
  require('./lib/client')

  get("/") do
    erb(:index)
  end

  get("/salons/new") do
    erb(:salon_form)
  end

  post("/salons") do
    name = params.fetch("name")
    salon = Salon.new({:name => name, :id => nil})
    if salon.save()
      erb(:salon_success)
    else
      erb(:errors) #catching errors
    end
  end

  get('/salons') do
    @salons = Salon.all()
    erb(:salons)
  end

  get('/add') do
    @salons = Salon.all()
    erb(:description_form)
  end

  get("/salons/:id") do
    @salon = Salon.find(params.fetch("id").to_i())
    erb(:salon)
  end

  post("/clients") do
    description = params.fetch("description")
    salon_id = params.fetch("salon_id").to_i()
    @salon = Salon.find(salon_id)
    @client = Client.new({:description => description, :salon_id => salon_id})
    @client.save()
    erb(:client_success)
  end

  get("/salons/:id/edit") do
    @salon = Salon.find(params.fetch("id").to_i())
    erb(:salon_edit)
  end

  patch("/salons/:id") do
    name = params.fetch("name")
    @salon = Salon.find(params.fetch("id").to_i())
    @salon.update({:name => name})
    erb(:salon_success)
  end

  delete("/salons/:id") do
    @salon = Salon.find(params.fetch("id").to_i())
    @salon.delete()
    @salons = Salon.all()
    erb(:salon_success)
  end