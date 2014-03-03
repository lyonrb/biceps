require 'biceps/core_ext/action_dispatch/routing/mapper'

module Biceps

  class << self
    attr_writer :app_name

    def app_name
      @app_name ||= 'biceps'
    end
  end
end

require 'biceps/api_version'
require 'biceps/test_helper'

require 'biceps/rack'

begin
  require 'biceps/rails'
rescue NameError
  # Rails::Engine is not defined. This is not a rails engine.
end
