$:.push 'lib'
require 'biceps/version'

Gem::Specification.new do |s|
  s.name        = "biceps"
  s.summary     = "Easy versioned API routing"
  s.description = "Create a versioned API with rails"
  s.files       = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.email       = ['contact@evome.fr', '42@dmathieu.com', 'franck@verrot.fr']
  s.authors     = ["Evome", "Damien MATHIEU", "Franck Verrot"]
  s.version     = Biceps::VERSION

  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest"
  s.add_development_dependency 'json',  '>= 1.6.1'

  s.add_dependency 'rake',  '>= 0.8.7'
  s.add_dependency 'rails', '>= 3.0.0'

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec}/*`.split("\n")
  s.require_paths      = ["lib"]
end
