# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active-record-instance-count/version"

Gem::Specification.new do |s|
  s.name        = "active-record-instance-count"
  s.version     = ActiveRecordInstanceCount::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Cody Caughlan"]
  s.email       = ["toolbag@gmail.com"]
  s.homepage    = ""
  s.summary     = "Rack middleware to write the number of instantiated ActiveRecord models to a log"
  s.description = s.summary

  #s.rubyforge_project = "active-record-instance-count"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
