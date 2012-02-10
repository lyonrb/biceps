# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'biceps/version'

Gem::Specification.new do |s|
  s.name         = "biceps"
  s.version      = Biceps::VERSION
  s.authors      = ["Evome"]
  s.email        = "dev@evome.fr"
  s.homepage     = "https://github.com/evome/biceps"
  s.summary     = "Leverage your api"
  s.description = "Create a versioned API with rails"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest"

  s.add_dependency 'rake',  '>= 0.8.7'
  s.add_dependency 'rails', '>= 3.0.0'
end
