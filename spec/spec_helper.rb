ENV['RACK_ENV'] = 'test'  #database connecting

require("rspec")
  require("pg")
  require("salon")
  require('client')

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM salons *;")
      DB.exec("DELETE FROM clients *;")
    end
  end