require 'rails'

class Biceps::Rails < Rails::Engine

  config.app_middleware.use Biceps::Rack
end
