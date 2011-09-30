ENV["RAILS_ENV"] ||= 'test'

require 'rails/all'
require 'rspec'
require 'biceps'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
