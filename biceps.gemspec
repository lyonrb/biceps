# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'biceps/version'

Gem::Specification.new do |s|
  s.name         = "biceps"
  s.version      = Biceps::VERSION
  s.authors      = ["Damien Mathieu"]
  s.email        = "42@dmathieu.com"
  s.homepage     = "https://github.com//biceps"
  s.summary      = "[summary]"
  s.description  = "[description]"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
