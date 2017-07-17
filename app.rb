require("bundler/setup")
  Bundler.require(:default)
  also_reload("lib/**/*.rb")

  Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file } #loading individual files when required

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

  # redirect code
  # post ('/clients')
  #   @new_client = Client.new(params.fetch("namme"))
  #   if @new_client.save()
  #     redirect("/clients/".concat(@new_client.id().to_s()))
  #   else
  #     erb(:index)
  #   end
  # end

  # get('/clients/:id') do
  #   @client = Client.find(params.fetch("id").to_i())
  #   erb(:client)
  # # end

  # delete('/tasks/:id') do
  #   @task = Task.find(params.fetch("id").to_i()
  #   if @task.destroy()
  #     redirect("/tasks")
  #   else
  #     erb(:task)
  #   end
  # end