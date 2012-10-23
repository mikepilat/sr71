# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sr71/version"

Gem::Specification.new do |s|
  s.name        = "sr71"
  s.version     = Sr71::VERSION
  s.authors     = ["Michael Pilat"]
  s.email       = ["mike@mikepilat.com"]
  s.homepage    = "http://mikepilat.com/"
  s.summary     = %q{A remote service monitor}
  s.description = %q{A remote service monitor}

  s.rubyforge_project = "sr71"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "eventmachine",      "~> 1.0.0"
  s.add_dependency "em-http-request",   "~> 1.0"

  s.add_development_dependency "rspec", "~> 2.11.0"
end
