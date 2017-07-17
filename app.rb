require("bundler/setup")
  Bundler.require(:default)
  also_reload("lib/**/*.rb")

  #loads first web page 'index'
  get("/") do
    erb(:index)
  end

  #loads the form to create a new record to database 'salonist'
  get("/salons/new") do
    erb(:salon_form)
  end

  #addes the user input from the form to database
  post("/salons") do
    name = params.fetch("name")
    salon = Salon.new({:name => name, :id => nil})
    if salon.save()
      erb(:salon_success)
    else
      erb(:errors) #catching errors
    end
  end

  #displays all the stylists from the database to the webpage
  get('/salons') do
    @salons = Salon.all()
    erb(:salons)
  end

  #loads the form to add a new record to database 'stylist'
  get('/add') do
    @salons = Salon.all()
    erb(:description_form)
  end

  #loads the specific record details when clicked
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