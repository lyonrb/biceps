module Biceps
  class Application < Rails::Application
    config.secret_token = 'x' * 30
  end
end
Rails.logger = Logger.new('/dev/null')
