require 'biceps/core_ext/action_dispatch/routing/mapper'
require 'biceps/core_ext/action_controller/base'

module Biceps
  autoload :ApiVersion,      'biceps/api_version'
  autoload :ModelVersioning, 'biceps/model_versioning'
  autoload :Jsonp,           'biceps/jsonp'
  autoload :Serializer,      'biceps/serializer'
  autoload :Parser,          'biceps/parser'
  autoload :Builder,         'biceps/builder'
  autoload :TestHelper,      'biceps/test_helper'
end
