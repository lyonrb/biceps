$:.push File.expand_path("../lib", __FILE__)
require 'biceps/version'

Gem::Specification.new do |s|
  s.name        = "biceps"
  s.summary     = "Easy versioned API routing"
  s.description = "Create a versioned API with rails"
  s.files       = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.email       = ['contact@evome.fr', '42@dmathieu.com', 'franck@verrot.fr']
  s.authors     = ["Evome", "Damien MATHIEU", "Franck Verrot"]
  s.version     = Biceps::VERSION
end
