$:.push File.expand_path("../lib", __FILE__)
require 'biceps/version'

Gem::Specification.new do |s|
  s.name = "biceps"
  s.summary = "Easy versionned API routing"
  s.description = "Create a versionned API with rails"
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.authors = ["Evome", "Damien MATHIEU"]
  s.version = Biceps::VERSION
end
