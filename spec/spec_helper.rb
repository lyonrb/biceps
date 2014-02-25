ENV["RAILS_ENV"] ||= 'test'

gem 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

$:<< 'lib'
require 'biceps'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
