require 'biceps/core_ext/action_dispatch/routing/mapper'

module Biceps; end

require 'biceps/api_version'
require 'biceps/rack'

begin
  require 'biceps/rails'
rescue NameError
  # Rails::Engine is not defined. This is not a rails engine.
end
