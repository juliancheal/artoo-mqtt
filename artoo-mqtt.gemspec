# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "artoo-mqtt/version"

Gem::Specification.new do |s|
  s.name        = "artoo-mqtt"
  s.version     = Artoo::Mqtt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Julian Cheal"]
  s.email       = ["julian.cheal@gmail.com"]
  s.homepage    = "http:://juliancheal.co.uk"
  s.license     = "MIT"
  s.summary     = %q{Artoo adaptor and driver for Mqtt}
  s.description = %q{Artoo adaptor and driver for Mqtt}

  s.rubyforge_project = "artoo-mqtt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'artoo', '>= 1.8.0'
  s.add_development_dependency 'mqtt', '>= 0.3.1'
end
