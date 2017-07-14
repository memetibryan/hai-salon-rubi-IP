ENV['RACK_ENV'] = 'test'  #database connecting

require("rspec")
  require("pg")
  require("salon")
  require('client')

  RSpec.configure do |config|
    config.after(:each) do
      Salon.all().each() do |salon|
        salon.destroy()
      end
      Client.all().each() do |client|
        client.destroy()
      end
    end
  end