# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pars/version'

Gem::Specification.new do |s|
  s.name        = 'pars'
  s.version     = Pars::VERSION
  s.date        = '2015-09-03'
  s.summary     = "Pars"
  s.description = "A static, static site generator!"
  s.authors     = ["Dariush Abbasi"]
  s.email       = 'poshtehani@gmail.com'
  s.files       = ['bin/pars', 'lib/pars.rb', 'lib/pars/generate.rb', 'lib/pars/cli.rb', 'lib/pars/version.rb']
  s.executables   = ["pars"]
  s.require_paths = ["lib"]
  s.homepage    =
    'http://github.com/dariubs/pars'
  s.license       = 'MIT'
end
