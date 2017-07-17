ENV['RACK_ENV'] = 'test'  #database connecting

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

#loading individual needed files when needed.
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }


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