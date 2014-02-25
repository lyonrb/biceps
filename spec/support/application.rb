require 'rails'

module Biceps
  class Application < Rails::Application
    config.secret_key_base = 'x' * 30
  end
end
Rails.logger = Logger.new('/dev/null')
