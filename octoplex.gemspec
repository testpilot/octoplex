# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "octoplex/version"

Gem::Specification.new do |s|
  s.name        = "octoplex"
  s.version     = Octoplex::VERSION
  s.authors     = ["Ivan Vanderbyl"]
  s.email       = ["ivanvanderbyl@me.com"]
  s.homepage    = "http://testpilot.me/testpilot/octoplex"
  s.summary     = %q{A lightweight wrapper around the Github v3 API}
  s.description = %q{A lightweight wrapper around the Github v3 API}

  s.rubyforge_project = "octoplex"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"

  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "multi_json"
  s.add_runtime_dependency "yajl-ruby"
end
